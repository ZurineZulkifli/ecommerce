-- FIXED E-commerce Database Schema
-- Fixes applied: constraints, indexes, data integrity

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Database: `ecommerce_db`

-- FIXED: Users table with proper constraints
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('customer','delivery') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  
  -- ADDED: Proper constraints
  CONSTRAINT `chk_username_length` CHECK (CHAR_LENGTH(`username`) >= 3),
  CONSTRAINT `chk_email_format` CHECK (`email` REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$'),
  CONSTRAINT `chk_password_length` CHECK (CHAR_LENGTH(`password`) >= 8),
  CONSTRAINT `chk_phone_format` CHECK (`phone` IS NULL OR `phone` REGEXP '^[0-9+\\-\\s]+$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- FIXED: Products table with constraints
CREATE TABLE `products` (
  `product_id` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  
  PRIMARY KEY (`product_id`),
  
  -- ADDED: Business constraints
  CONSTRAINT `chk_price_positive` CHECK (`price` >= 0),
  CONSTRAINT `chk_stock_non_negative` CHECK (`stock` >= 0),
  CONSTRAINT `chk_product_name_length` CHECK (CHAR_LENGTH(`name`) >= 1),
  
  -- ADDED: Performance indexes
  INDEX `idx_products_name` (`name`),
  INDEX `idx_products_price` (`price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- FIXED: Orders table with proper status handling
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','paid','shipped','delivered','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `payment_method` varchar(100) DEFAULT NULL,
  
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  
  -- ADDED: Business constraints
  CONSTRAINT `chk_total_amount_positive` CHECK (`total_amount` > 0),
  
  -- ADDED: Performance indexes
  INDEX `idx_orders_status` (`status`),
  INDEX `idx_orders_created_at` (`created_at`),
  
  -- Foreign key constraint
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- FIXED: Order items with proper constraints
CREATE TABLE `order_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` varchar(10) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  
  PRIMARY KEY (`item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  
  -- ADDED: Business constraints
  CONSTRAINT `chk_quantity_positive` CHECK (`quantity` > 0),
  CONSTRAINT `chk_item_price_positive` CHECK (`price` >= 0),
  
  -- Prevent duplicate items in same order
  UNIQUE KEY `uk_order_product` (`order_id`, `product_id`),
  
  -- Foreign key constraints
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- FIXED: Deliveries table with proper constraints
CREATE TABLE `deliveries` (
  `delivery_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `status` enum('pending','awaiting_dispatch','in_transit','delivered','failed') DEFAULT 'pending',
  `delivery_date` timestamp NULL DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  
  PRIMARY KEY (`delivery_id`),
  KEY `order_id` (`order_id`),
  KEY `assigned_to` (`assigned_to`),
  
  -- ADDED: Performance indexes
  INDEX `idx_deliveries_status` (`status`),
  INDEX `idx_deliveries_delivery_date` (`delivery_date`),
  
  -- Foreign key constraints
  CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `deliveries_ibfk_2` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ADDED: Audit log table for tracking changes
CREATE TABLE `audit_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) NOT NULL,
  `operation` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `record_id` int(11) NOT NULL,
  `old_values` json DEFAULT NULL,
  `new_values` json DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  
  PRIMARY KEY (`log_id`),
  INDEX `idx_audit_table_name` (`table_name`),
  INDEX `idx_audit_operation` (`operation`),
  INDEX `idx_audit_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- AUTO_INCREMENT settings
ALTER TABLE `deliveries` MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `orders` MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `order_items` MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `users` MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;