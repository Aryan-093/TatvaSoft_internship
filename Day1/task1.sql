-- Step 1: Create the Customer Table
CREATE TABLE customer (
    cust_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_updated TIMESTAMPTZ,
    active BOOLEAN DEFAULT true
);

-- Step 2: Select All Customers
SELECT * FROM customer;

-- Step 3: Drop the Customer Table If Exists
DROP TABLE IF EXISTS customer;

-- Step 4: Add a New Column to Customer
ALTER TABLE customer ADD COLUMN vip_status BOOLEAN;

-- Step 5: Drop the Newly Added Column
ALTER TABLE customer DROP COLUMN vip_status;

-- Step 6: Rename Columns
ALTER TABLE customer RENAME COLUMN email TO contact_email;
ALTER TABLE customer RENAME COLUMN contact_email TO email;

-- Step 7: Rename Table
ALTER TABLE customer RENAME TO clients;
ALTER TABLE clients RENAME TO customer;

-- Step 8: Create Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    cust_id INT NOT NULL REFERENCES customer(cust_id),
    order_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    order_ref VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

-- Step 9: Insert a Single Record in Customer
INSERT INTO customer (first_name, last_name, email, created_at, last_updated, active)
VALUES ('Aanya', 'Malik', 'aanya.malik@samplemail.com', NOW(), NULL, true);

-- Step 10: Insert Multiple Customer Records
INSERT INTO customer (first_name, last_name, email, created_at, last_updated, active) VALUES
  ('Vivaan', 'Arora', 'vivaan.arora@example.com', NOW(), NULL, true),
  ('Meera', 'Kohli', 'meera.kohli@example.com', NOW(), NULL, true),
  ('Raghav', 'Menon', 'raghav.menon@example.com', NOW(), NULL, true),
  ('Ishita', 'Rana', 'ishita.rana@example.com', NOW(), NULL, true),
  ('Aryan', 'Chatterjee', 'aryan.chat@example.com', NOW(), NULL, false),
  ('Saanvi', 'Bajaj', 'saanvi.b@example.com', NOW(), NULL, true),
  ('Laksh', 'Kapoor', 'laksh.kapoor@example.com', NOW(), NULL, true),
  ('Trisha', 'Pandey', 'trisha.p@example.com', NOW(), NULL, true),
  ('Advait', 'Saxena', 'advait.saxena@example.com', NOW(), NULL, false),
  ('Ria', 'Dutta', 'ria.d@example.com', NOW(), NULL, false);

-- Step 11: Insert Orders
INSERT INTO orders (cust_id, order_date, order_ref, amount) VALUES
  (1, '2024-04-01', 'ORD101', 125.00),
  (2, '2024-04-01', 'ORD102', 250.00),
  (3, '2024-04-01', 'ORD103', 89.99),
  (4, '2024-04-01', 'ORD104', 145.75),
  (5, '2024-04-01', 'ORD105', 199.50),
  (1, '2024-04-02', 'ORD106', 175.00),
  (2, '2024-04-03', 'ORD107', 160.60),
  (1, '2024-04-04', 'ORD108', 220.90),
  (3, '2024-04-04', 'ORD109', 130.00),
  (2, '2024-04-05', 'ORD110', 110.00);

-- Step 12: Basic Select Queries
SELECT first_name FROM customer;
SELECT first_name, last_name, email FROM customer;
SELECT * FROM customer;

-- Step 13: ORDER BY
SELECT first_name, last_name FROM customer ORDER BY first_name ASC;
SELECT first_name, last_name FROM customer ORDER BY last_name DESC;
SELECT cust_id, first_name, last_name FROM customer ORDER BY first_name ASC, last_name DESC;

-- Step 14: WHERE Clause
SELECT last_name, first_name FROM customer WHERE first_name = 'Ria';
SELECT cust_id, first_name, last_name FROM customer WHERE first_name = 'Ria' OR last_name = 'Rana';
SELECT cust_id, first_name, last_name FROM customer WHERE first_name IN ('Vivaan', 'Laksh', 'Raghav');
SELECT first_name, last_name FROM customer WHERE first_name LIKE '%AN%';
SELECT first_name, last_name FROM customer WHERE first_name ILIKE '%AN%';

-- Step 15: JOINs
SELECT * FROM orders AS o INNER JOIN customer AS c ON o.cust_id = c.cust_id;
SELECT * FROM customer AS c LEFT JOIN orders AS o ON c.cust_id = o.cust_id;

-- Step 16: Aggregation with GROUP BY
SELECT c.cust_id, c.first_name, c.last_name, c.email,
       COUNT(o.order_id) AS order_count,
       SUM(o.amount) AS total_spent
FROM customer AS c
JOIN orders AS o ON c.cust_id = o.cust_id
GROUP BY c.cust_id;

-- Step 17: GROUP BY with HAVING
SELECT c.cust_id, c.first_name, c.last_name, c.email,
       COUNT(o.order_id) AS order_count,
       SUM(o.amount) AS total_spent
FROM customer AS c
JOIN orders AS o ON c.cust_id = o.cust_id
GROUP BY c.cust_id
HAVING COUNT(o.order_id) > 2;

-- Step 19: Subqueries
-- IN operator
SELECT * FROM orders WHERE cust_id IN (
  SELECT cust_id FROM customer WHERE active = true
);

-- EXISTS operator
SELECT cust_id, first_name, last_name, email
FROM customer
WHERE EXISTS (
  SELECT 1 FROM orders WHERE orders.cust_id = customer.cust_id
);

-- Step 20: Update Statement
UPDATE customer
SET first_name = 'aanya', last_name = 'malik', email = 'aanya.malik@samplemail.com'
WHERE cust_id = 1;

-- Step 21: Delete Statement
DELETE FROM customer WHERE cust_id = 5;

