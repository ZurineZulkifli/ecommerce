-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 22, 2025 at 11:27 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `delivery_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `delivery_user_id` int(11) NOT NULL,
  `status` enum('pending','delivered') DEFAULT 'pending',
  `delivery_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`delivery_id`, `order_id`, `delivery_user_id`, `status`, `delivery_date`) VALUES
(40, 1001, 8, 'pending', '2025-07-22 06:31:47'),
(41, 1002, 8, 'pending', '2025-07-22 06:31:47');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','shipped','delivered') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `payment_method` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `delivery_address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_amount`, `status`, `created_at`, `payment_method`, `address`, `delivery_address`) VALUES
(1, 1, 1245.00, 'pending', '2025-07-17 22:17:33', NULL, NULL, 'Dummy Street #1'),
(2, 1, 90.00, 'shipped', '2025-07-17 22:17:33', NULL, NULL, 'Dummy Street #2'),
(3, 5, 1200.00, 'pending', '2025-07-19 09:21:28', NULL, NULL, 'Dummy Street #3'),
(4, 5, 45.00, 'pending', '2025-07-19 09:40:54', NULL, NULL, 'Dummy Street #4'),
(5, 5, 3200.00, 'pending', '2025-07-19 09:41:28', NULL, NULL, 'Dummy Street #5'),
(6, 5, 90.00, 'pending', '2025-07-19 09:48:09', NULL, NULL, 'Dummy Street #6'),
(7, 5, 25.00, 'pending', '2025-07-19 09:53:31', NULL, NULL, 'Dummy Street #7'),
(8, 5, 3200.00, 'pending', '2025-07-19 11:01:19', NULL, NULL, 'Dummy Street #8'),
(9, 5, 25.00, 'pending', '2025-07-19 11:02:06', NULL, NULL, 'Dummy Street #9'),
(10, 5, 1200.00, 'pending', '2025-07-19 11:13:47', NULL, NULL, 'Dummy Street #10'),
(11, 5, 25.00, 'pending', '2025-07-19 16:20:26', NULL, NULL, 'Dummy Street #11'),
(12, 5, 25.00, 'pending', '2025-07-19 17:50:16', NULL, NULL, 'Dummy Street #12'),
(13, 5, 90.00, 'pending', '2025-07-19 17:54:37', NULL, NULL, 'Dummy Street #13'),
(14, 5, 25.00, 'pending', '2025-07-20 07:23:16', NULL, NULL, 'Dummy Street #14'),
(15, 5, 90.00, 'pending', '2025-07-20 07:28:00', NULL, NULL, 'Dummy Street #15'),
(16, 5, 90.00, 'pending', '2025-07-20 07:54:21', NULL, NULL, 'Dummy Street #16'),
(17, 5, 90.00, 'pending', '2025-07-20 08:03:28', NULL, NULL, 'Dummy Street #17'),
(18, 5, 25.00, 'pending', '2025-07-20 08:04:54', NULL, NULL, 'Dummy Street #18'),
(19, 5, 90.00, 'pending', '2025-07-20 08:06:12', NULL, NULL, 'Dummy Street #19'),
(20, 5, 25.00, 'pending', '2025-07-20 08:29:12', NULL, NULL, 'Dummy Street #20'),
(21, 5, 90.00, 'pending', '2025-07-20 08:51:20', NULL, NULL, 'Dummy Street #21'),
(22, 5, 45.00, 'pending', '2025-07-20 08:58:02', NULL, NULL, 'Dummy Street #22'),
(23, 5, 3200.00, 'pending', '2025-07-20 09:04:20', NULL, NULL, 'Dummy Street #23'),
(24, 5, 25.00, 'pending', '2025-07-20 09:10:57', NULL, NULL, 'Dummy Street #24'),
(26, 5, 90.00, 'pending', '2025-07-20 09:19:17', NULL, NULL, 'Dummy Street #26'),
(27, 5, 25.00, 'pending', '2025-07-20 09:21:17', NULL, NULL, 'Dummy Street #27'),
(28, 5, 25.00, 'pending', '2025-07-20 09:24:08', NULL, NULL, 'Dummy Street #28'),
(29, 5, 25.00, 'pending', '2025-07-20 09:59:28', NULL, NULL, 'Dummy Street #29'),
(30, 5, 25.00, 'pending', '2025-07-21 04:36:04', NULL, NULL, 'Dummy Street #30'),
(31, 5, 25.00, 'pending', '2025-07-21 05:00:51', NULL, NULL, 'Dummy Street #31'),
(32, 5, 90.00, 'pending', '2025-07-21 05:16:41', NULL, NULL, 'Dummy Street #32'),
(33, 5, 90.00, 'pending', '2025-07-21 05:31:26', NULL, NULL, 'Dummy Street #33'),
(38, 5, 135.00, 'pending', '2025-07-21 11:48:27', NULL, NULL, 'Dummy Street #38'),
(42, 9, 59.90, 'pending', '2025-07-22 05:19:40', 'Cash', NULL, '456 Delivery Street'),
(1001, 14, 2999.00, '', '2025-07-22 06:29:32', 'Credit Card', NULL, '12 Jalan Bukit, Melaka'),
(1002, 14, 2298.00, '', '2025-07-22 06:29:32', 'COD', NULL, '45 Lorong Mawar, KL');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` varchar(10) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 'P001', 1, 1200.00),
(2, 1, 'P002', 1, 45.00),
(3, 2, 'P004', 1, 90.00),
(4, 3, 'P001', 1, 1200.00),
(5, 4, 'P002', 1, 45.00),
(6, 5, 'P003', 1, 3200.00),
(7, 6, 'P004', 1, 90.00),
(8, 7, 'P005', 1, 25.00),
(9, 8, 'P003', 1, 3200.00),
(10, 9, 'P005', 1, 25.00),
(11, 10, 'P001', 1, 1200.00),
(12, 11, 'P005', 1, 25.00),
(13, 12, 'P005', 1, 25.00),
(14, 13, 'P004', 1, 90.00),
(15, 14, 'P005', 1, 25.00),
(16, 15, 'P004', 1, 90.00),
(17, 16, 'P004', 1, 90.00),
(18, 17, 'P004', 1, 90.00),
(19, 18, 'P005', 1, 25.00),
(20, 19, 'P004', 1, 90.00),
(21, 20, 'P005', 1, 25.00),
(22, 21, 'P004', 1, 90.00),
(23, 22, 'P002', 1, 45.00),
(24, 23, 'P003', 1, 3200.00),
(25, 24, 'P005', 1, 25.00),
(26, 25, 'P002', 1, 45.00),
(27, 26, 'P004', 1, 90.00),
(28, 27, 'P005', 1, 25.00),
(29, 28, 'P005', 1, 25.00),
(30, 29, 'P005', 1, 25.00),
(31, 30, 'P005', 1, 25.00),
(32, 31, 'P005', 1, 25.00),
(33, 32, 'P004', 1, 90.00),
(34, 33, 'P004', 1, 90.00),
(35, 34, 'P005', 1, 25.00),
(36, 35, 'P005', 1, 25.00),
(37, 36, 'P004', 1, 90.00),
(38, 37, 'P001', 1, 1200.00),
(39, 38, 'P004', 1, 90.00),
(40, 38, 'P002', 1, 45.00),
(41, 39, 'P004', 1, 90.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `stock`, `created_at`) VALUES
('P001', 'Smartphone', '5G-enabled Android phone', 1200.00, 47, '2025-07-17 22:17:33'),
('P002', 'Wireless Mouse', 'Ergonomic design, USB', 45.00, 96, '2025-07-17 22:17:33'),
('P003', 'Laptop', 'Intel i7, 16GB RAM, 512GB SSD', 3200.00, 17, '2025-07-17 22:17:33'),
('P004', 'Headphones', 'Noise cancelling over-ear', 90.00, 62, '2025-07-17 22:17:33'),
('P005', 'USB-C Charger', 'Fast charging 20W', 25.00, 185, '2025-07-17 22:17:33');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('customer','delivery') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `default_address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `phone`, `role`, `created_at`, `default_address`) VALUES
(5, 'zurine', 'zurine@gmail.com', '$2y$10$z4oVk5M8KQo9qOxTHJUs2e5z2n.pXx3W2N26sqxE7Qcw8ohUXpime', '0138652418', 'customer', '2025-07-19 07:29:32', '1, Jalan Perdana, Melaka'),
(8, 'aishah', 'aishah@gmail.com', '$2y$10$OmJFNUHezfX6DoCHk2E.quQ/uhKlSFrRdGzXYe/KWUer7TTouR8IW', '012345634', 'delivery', '2025-07-21 14:44:31', NULL),
(14, 'alice', 'alice@example.com', '$2y$10$CKzUxeE5PRY6vVUg5A9zUOTM7VNBqPDXL3w8iW1qoz9TlhgYq7e.C', '0111000001', 'customer', '2025-07-22 06:24:27', '12 Jalan Bukit, Melaka'),
(15, 'bob', 'bob@example.com', '$2y$10$CKzUxeE5PRY6vVUg5A9zUOTM7VNBqPDXL3w8iW1qoz9TlhgYq7e.C', '0111000002', 'customer', '2025-07-22 06:24:27', '45 Lorong Mawar, KL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`delivery_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `assigned_to` (`delivery_user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1004;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `deliveries_ibfk_2` FOREIGN KEY (`delivery_user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
