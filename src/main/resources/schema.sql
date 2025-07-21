-- E-commerce Database Schema with Bugs

-- BUG 11: Missing indexes on frequently queried columns
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL, -- BUG 12: No check for password length/complexity
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -- BUG 13: Missing unique constraints on username and email
);

-- BUG 14: Poor naming convention and missing constraints
CREATE TABLE orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL, -- BUG 15: No check constraint for valid status values
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
    -- BUG 16: Missing ON DELETE constraint specification
);

-- BUG 17: Missing junction table for many-to-many relationships
CREATE TABLE products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
    -- BUG 18: No check constraint for positive price and stock
);

-- BUG 19: Inefficient design - storing order items without proper normalization
CREATE TABLE order_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_name VARCHAR(255), -- BUG 20: Denormalized - should reference product table
    product_price DECIMAL(10,2),
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- BUG 21: Missing audit trail tables
-- BUG 22: No proper indexing strategy for performance