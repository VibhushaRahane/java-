CREATE DATABASE ecommerce_db;
USE ecommerce_db;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers VALUES
(1, 'Amit Sharma', 'amit@gmail.com', 'Mumbai'),
(2, 'Neha Singh', 'neha@gmail.com', 'Delhi'),
(3, 'Rahul Verma', 'rahul@gmail.com', 'Pune');

INSERT INTO Products VALUES
(1, 'Laptop', 60000),
(2, 'Phone', 20000),
(3, 'Headphones', 3000);

INSERT INTO Orders VALUES
(101, 1, '2025-03-01'),
(102, 2, '2025-03-02'),
(103, 1, '2025-03-05');

INSERT INTO Order_Items VALUES
(1, 101, 1, 1),
(2, 101, 3, 2),
(3, 102, 2, 1),
(4, 103, 2, 1);

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT c.name, o.order_id, o.order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id;
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;
SELECT name
FROM Customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM Orders
);
CREATE VIEW Customer_Spending AS
SELECT c.name, SUM(p.price * oi.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.name;
CREATE INDEX idx_customer ON Orders(customer_id);
SELECT c.city, SUM(p.price * oi.quantity) AS revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.city;
SELECT MONTH(order_date) AS month, COUNT(*) AS total_orders
FROM Orders
GROUP BY MONTH(order_date);