CREATE DATABASE ecommerce_analysis;
SHOW DATABASES;
USE ecommerce_analysis;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

SHOW TABLES;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
SHOW TABLES;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
SHOW TABLES;

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
SHOW TABLES;

INSERT INTO customers (customer_id, customer_name, city, state, signup_date)
VALUES
(101, 'Rahul Sharma', 'Mumbai', 'Maharashtra', '2025-01-10'),
(102, 'Amit Verma', 'Pune', 'Maharashtra', '2025-01-15'),
(103, 'Priya Singh', 'Delhi', 'Delhi', '2025-02-01'),
(104, 'Sneha Patel', 'Ahmedabad', 'Gujarat', '2025-02-10'),
(105, 'Rohit Kumar', 'Bengaluru', 'Karnataka', '2025-02-15'),
(106, 'Neha Gupta', 'Hyderabad', 'Telangana', '2025-03-01'),
(107, 'Vikas Das', 'Kolkata', 'West Bengal', '2025-03-05'),
(108, 'Anjali Mehta', 'Jaipur', 'Rajasthan', '2025-03-10'),
(109, 'Karan Joshi', 'Mumbai', 'Maharashtra', '2025-03-15'),
(110, 'Pooja Roy', 'Chennai', 'Tamil Nadu', '2025-03-20');

SELECT * FROM customers;

-- Insert product data into products table

INSERT INTO products (product_id, product_name, category, price)
VALUES
(201, 'Laptop', 'Electronics', 55000.00),
(202, 'Mobile Phone', 'Electronics', 25000.00),
(203, 'Headphones', 'Electronics', 1500.00),
(204, 'Office Chair', 'Furniture', 5000.00),
(205, 'Desk', 'Furniture', 8000.00),
(206, 'Keyboard', 'Accessories', 1200.00),
(207, 'Mouse', 'Accessories', 800.00),
(208, 'Monitor', 'Electronics', 12000.00),
(209, 'Printer', 'Electronics', 9000.00),
(210, 'Backpack', 'Accessories', 2000.00);

-- Check all product records

SELECT * FROM products;

-- Insert order data into orders table

INSERT INTO orders (order_id, customer_id, order_date, order_status)
VALUES
(5001, 101, '2025-04-01', 'Delivered'),
(5002, 102, '2025-04-02', 'Delivered'),
(5003, 103, '2025-04-03', 'Pending'),
(5004, 104, '2025-04-04', 'Delivered'),
(5005, 105, '2025-04-05', 'Cancelled'),
(5006, 106, '2025-04-06', 'Delivered'),
(5007, 107, '2025-04-07', 'Pending'),
(5008, 108, '2025-04-08', 'Delivered'),
(5009, 109, '2025-04-09', 'Delivered'),
(5010, 110, '2025-04-10', 'Cancelled'),
(5011, 101, '2025-04-11', 'Delivered'),
(5012, 102, '2025-04-12', 'Delivered'),
(5013, 103, '2025-04-13', 'Delivered'),
(5014, 104, '2025-04-14', 'Pending'),
(5015, 105, '2025-04-15', 'Delivered');

-- Check all orders

SELECT * FROM orders;

-- Insert data into order_details table

INSERT INTO order_details (order_detail_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 5001, 207, 2, 800.00),
(2, 5001, 206, 1, 1200.00),
(3, 5002, 202, 1, 25000.00),
(4, 5002, 203, 2, 1500.00),
(5, 5003, 201, 1, 55000.00),
(6, 5004, 204, 2, 5000.00),
(7, 5004, 205, 1, 8000.00),
(8, 5005, 207, 1, 800.00),
(9, 5006, 208, 2, 12000.00),
(10, 5006, 203, 1, 1500.00),
(11, 5007, 210, 3, 2000.00),
(12, 5008, 209, 1, 9000.00),
(13, 5008, 206, 2, 1200.00),
(14, 5009, 202, 1, 25000.00),
(15, 5009, 207, 2, 800.00),
(16, 5010, 201, 1, 55000.00),
(17, 5011, 203, 2, 1500.00),
(18, 5011, 208, 1, 12000.00),
(19, 5012, 206, 1, 1200.00),
(20, 5012, 207, 3, 800.00),
(21, 5013, 202, 2, 25000.00),
(22, 5013, 210, 1, 2000.00),
(23, 5014, 204, 1, 5000.00),
(24, 5014, 205, 2, 8000.00),
(25, 5015, 209, 1, 9000.00),
(26, 5015, 203, 2, 1500.00);

-- Check all order details

SELECT * FROM order_details;

-- Calculate total sales revenue
SELECT 
    SUM(quantity * unit_price) AS total_revenue
FROM order_details;

-- Q2: Calculate total number of orders
SELECT
    COUNT(order_id) AS total_orders
FROM orders;

-- Q3: Calculate total number of customers
SELECT
    COUNT(customer_id) AS total_customers
FROM customers;

-- Q4: Count total products
SELECT
    COUNT(product_id) AS total_products
FROM products;

-- Q5: Calculate Average Order Value
SELECT
    SUM(quantity * unit_price) / COUNT(DISTINCT order_id) AS average_order_value
FROM order_details;

-- Q6: Calculate monthly sales
SELECT
    MONTH(order_date) AS month_number,
    SUM(order_details.quantity * order_details.unit_price) AS monthly_sales
FROM orders
JOIN order_details
    ON orders.order_id = order_details.order_id
GROUP BY MONTH(order_date)
ORDER BY month_number;

-- Q7: Calculate city-wise sales
SELECT
    customers.city,
    SUM(order_details.quantity * order_details.unit_price) AS city_sales
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_details
    ON orders.order_id = order_details.order_id
GROUP BY customers.city
ORDER BY city_sales DESC;

-- Q8: Calculate state-wise sales
SELECT
    customers.state,
    SUM(order_details.quantity * order_details.unit_price) AS state_sales
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_details
    ON orders.order_id = order_details.order_id
GROUP BY customers.state
ORDER BY state_sales DESC;

-- Q9: Analyze order status
SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status;

-- Q10: Calculate revenue from delivered orders only
SELECT
    SUM(order_details.quantity * order_details.unit_price) AS delivered_revenue
FROM orders
JOIN order_details
    ON orders.order_id = order_details.order_id
WHERE orders.order_status = 'Delivered';

-- Q11: Find top 5 best-selling products
SELECT
    products.product_name,
    SUM(order_details.quantity) AS total_quantity_sold
FROM products
JOIN order_details
    ON products.product_id = order_details.product_id
GROUP BY products.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Q12: Find top revenue-generating products
SELECT
    products.product_name,
    SUM(order_details.quantity * order_details.unit_price) AS total_revenue
FROM products
JOIN order_details
    ON products.product_id = order_details.product_id
GROUP BY products.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Q13: Calculate revenue by product category
SELECT
    products.category,
    SUM(order_details.quantity * order_details.unit_price) AS category_revenue
FROM products
JOIN order_details
    ON products.product_id = order_details.product_id
GROUP BY products.category
ORDER BY category_revenue DESC;

-- Q14: Identify low-performing products
SELECT
    products.product_name,
    SUM(order_details.quantity) AS total_quantity_sold
FROM products
JOIN order_details
    ON products.product_id = order_details.product_id
GROUP BY products.product_name
ORDER BY total_quantity_sold ASC
LIMIT 5;

-- Q15: Find top 5 customers by number of orders
SELECT
    customers.customer_name,
    COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name
ORDER BY total_orders DESC
LIMIT 5;

-- Q16: Identify repeat customers
SELECT
    customers.customer_name,
    COUNT(orders.order_id) AS total_orders
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name
HAVING COUNT(orders.order_id) > 1
ORDER BY total_orders DESC;

-- Q17: Calculate revenue generated by each customer
SELECT
    customers.customer_name,
    SUM(order_details.quantity * order_details.unit_price) AS total_revenue
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_details
    ON orders.order_id = order_details.order_id
GROUP BY customers.customer_name
ORDER BY total_revenue DESC;

-- Q18: Classify customers based on spending
SELECT
    customers.customer_name,
    SUM(order_details.quantity * order_details.unit_price) AS total_spending,
    CASE
        WHEN SUM(order_details.quantity * order_details.unit_price) >= 50000 THEN 'High Value'
        WHEN SUM(order_details.quantity * order_details.unit_price) >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_category
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_details
    ON orders.order_id = order_details.order_id
GROUP BY customers.customer_name
ORDER BY total_spending DESC;

-- Q19: Rank products based on revenue
SELECT
    products.product_name,
    SUM(order_details.quantity * order_details.unit_price) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(order_details.quantity * order_details.unit_price) DESC
    ) AS product_rank
FROM products
JOIN order_details
    ON products.product_id = order_details.product_id
GROUP BY products.product_name;

-- Select our e-commerce project database

USE ecommerce_analysis;

-- Calculate total revenue from all orders
SELECT
    SUM(quantity * unit_price) AS total_revenue
FROM order_details;

-- Calculate revenue from delivered orders only
SELECT
    SUM(od.quantity * od.unit_price) AS delivered_revenue
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
WHERE o.order_status = 'Delivered';

-- Calculate revenue from pending orders
SELECT
    SUM(od.quantity * od.unit_price) AS pending_revenue
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
WHERE o.order_status = 'Pending';

-- Calculate revenue from cancelled orders
SELECT
    SUM(od.quantity * od.unit_price) AS cancelled_revenue
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
WHERE o.order_status = 'Cancelled';

SELECT CURRENT_USER();
