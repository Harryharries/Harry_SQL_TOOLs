-- select *
-- from Customers
-- where state IN ('VA', 'FL', 'GA');

-- SELECT *
-- FROM customers
-- where points >= 1000 AND points <= 3000;

-- SELECT *
-- FROM customers
-- where points between 1000 and 3000;

-- select *
-- from Customers
-- WHERE last_name like '_____y';

-- select *
-- from Customers
-- WHERE last_name REGEXP 'ey$|on$';

-- -- ^ beginning
-- -- $ end
-- -- | logical or
-- -- [asdw]
-- -- [a-g]

-- Select *
-- from customers
-- where phone IS NULL;

-- select *
-- from customers
-- order by STATE DESC,points ASC;

-- SELECT *, quantity * unit_price AS total_price
-- FROM order_items
-- WHERE order_id = 2;

-- select *
-- from customers
-- Limit 3


-- select order_id, last_name, o.customer_id
-- from orders o
-- INNER JOIN customers c
-- on o.customer_id = c.customer_id

-- SELECT oi.quantity, oi.unit_price
-- from order_items oi
-- inner join products p
-- on p.product_id = oi.product_id;

--

-- SELECT *
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	ON oi.order_id = oin.order_id
--     AND oi.product_id = oin.product_id;

 -- outer join 
 -- inner join only can see customer who did order
-- SELECT c.customer_id, c.first_name, o.order_id, sh.name AS shipper
-- FROM customers c
-- LEFT JOIN orders o
-- ON c.customer_id = o.customer_id
-- LEFT JOIN shippers sh
-- ON o.shipper_id = sh.shipper_id
-- ORDER BY c.customer_id;

-- SELECT o.order_date, o.order_id, c.first_name, sh.name AS shipper, os.name AS status
-- FROM orders o
-- JOIN customers c
-- ON o.customer_id = c.customer_id
-- LEFT JOIN shippers sh
-- ON o.shipper_id = sh.shipper_id
-- JOIN order_statuses os
-- on o.status = os.order_status_id;

-- USE sql_hr;

-- SELECT e.employee_id, e.first_name, m.first_name AS manager
-- FROM employees e
-- LEFT JOIN employees m
-- 	ON e.reports_to = m.employee_id;

-- USE sql_store;
-- select *
-- from orders o
-- JOIN customers c
-- USING (customer_id)
-- ORDER BY customer_id;
-- -- ON o.customer_id = c.customer_id;

-- Natural join: it is decided by db engine---
-- SELECT o.order_id, c.first_name
-- FROM orders o
-- NATURAL JOIN customers c

-- SELECT *
-- FROM order_statuses os1
-- CROSS JOIN order_statuses os2

-- SELECT customer_id, first_name, points, 'Bronze' AS type
-- FROM customers
-- WHERE points <2000
-- UNION
-- SELECT customer_id, first_name, points, 'silver' AS type
-- FROM customers
-- WHERE points BETWEEN 2000 AND 3000
-- UNION
-- SELECT customer_id, first_name, points, 'gold' AS type
-- FROM customers
-- WHERE points > 3000

-- SELECT * FROM customers
-- INSERT INTO customers (
-- 	first_name,
--     last_name,
--     address,
--     city,
--     state
-- )
-- VALUE (
--     'Jonh',
--     'Smith',
--     'Address',
--     'city',
--     'CA'
--     );
-- use sql_store;
-- INSERT INTO customers
-- VALUE (
-- 	DEFAULT, 
--     'JonhWW',
--     'SmithWS',
--     NULL,
--     NULL,
--     'Address',
--     'city',
--     'CA',
--     default
--     );

-- INSERT INTO shippers (name)
-- VALUES ('Shipper1'),
-- 	('Shipper2'),
--     ('Shipper3')
-- INSERT INTO orders (customer_id, order_date, status)
-- VALUES (1,'2019-01-02',1);

-- INSERT INTO order_items
-- VALUES 
-- 	(last_insert_id(),1,1,3.00),
--     (last_insert_id(),2,1,13.00);

-- CREATE TABLE orders_archived AS 
-- SELECT * FROM orders;

-- INSERT INTO orders_archived
-- SELECT *
-- FROM orders
-- WHERE order_date < '2019-01-01';

-- USE sql_invoicing;
-- CREATE TABLE invoices_archived AS
-- SELECT i.invoice_id, i.number, c.name, i.invoice_total,i.invoice_date, i.due_date, i.payment_date
-- FROM invoices i
-- Join clients c ON i.client_id = c.client_id
-- WHERE i.payment_date IS NOT NULL;

-- USE sql_invoicing;
-- UPDATE invoices
-- SET payment_total = invoice_total * 0.3
-- WHERE client_id IN 
-- 	(SELECT client_id
--     FROM clients
--     WHERE name = 'Myworks'
-- 	);

-- DELETE FROM invoices
-- WHERE client_id IN (
-- 	SELECT client_id
--     FROM clients
--     WHERE name = 'Myworks'
-- );

USE sql_invoicing;
-- SELECT
-- 	MAX(invoice_total) AS hightest,
--     MIN(invoice_total) AS lowest,
--     AVG(invoice_total) AS average,
--     SUM(invoice_total) AS total,
--     COUNT(*) AS total_invoice,
--     COUNT(DISTINCT client_id) AS total_distinct_invoice
-- FROM invoices
-- WHERE invoice_date > '2019-07-01';
    
-- SELECT
-- 	state,
--     city,
-- 	SUM(invoice_total) AS total_sales
-- FROM invoices i
-- JOIN clients c USING (client_id)
-- Group BY state, city

-- SELECT
-- 	p.date,
--     pm.name,
--     SUM(p.amount) AS total_payments
-- FROM payments p
-- JOIN payment_methods pm WHERE pm.payment_method_id = p.payment_method
-- GROUP BY p.date, pm.name;

-- SELECT
-- 	client_id,
--     SUM(invoice_total) AS total_sales
-- FROM invoices
-- GROUP BY client_id
-- HAVING total_sales > 500;

-- Find clients without invoices
-- SELECT *
-- FROM clients
-- WHERE client_id NOT IN(
-- 	SELECT DISTINCT client_id
--     FROM invoices
--     );

-- SELECT *
-- FROM clients
-- JOIN invoices USING (client_id)
-- WHERE invoice_id IS NULL;

-- SELECT *
-- FROM invoices
-- WHERE invoice_total > ALL (
-- 	SELECT invoice_total
--     FROM invoice
--     WHERE client_id =3
-- )

-- USE sql_hr;
-- SELECT *
-- FROM employees e
-- WHERE salary > (
-- 	SELECT AVG(salary)
--     FROM employees
--     -- WHERE office_id = e.office_id
-- );



-- USE sql_invoicing;
 -- select clients that have an invoice
-- SELECT *
-- FROM clients
-- WHERE client_id IN (
-- 	SELECT DISTINCT client_id
--     FROM invoices
--     )
-- SELECT *
-- FROM clients c
-- WHERE EXISTS (
-- 	SELECT client_id
--     FROM invoices
--     WHERE client_id = c.client_id
--     )

-- SELECT ROUND(8.212); -- 8
-- SELECT ROUND(8.612); -- 9
-- SELECT ROUND(8.212,2); -- 8.21
-- SELECT CEILING(8.212); -- 9
-- SELECT FLOOR(8.212); -- 8
-- SELECT ABS(-2); -- 2
-- SELECT RAND(); -- 0-1 RANDOM

-- USE sql_invoicing;

-- CREATE VIEW sales_by_client AS
-- SELECT 
-- 	c.client_id,
--     c.name,
--     SUM(invoice_total) AS total_sales
-- FROM clients c
-- JOIN invoices i USING (client_id)
-- GROUP BY c.client_id,c.name

-- CREATE VIEW clients_balance AS
-- SELECT 
-- 	i.client_id,
--     c.name,
-- 	SUM(i.invoice_total)-SUM(i.payment_total) as balance
-- FROM invoices i
-- JOIN clients c USING (client_id)
-- GROUP BY i.client_id,c.name

use sql_store;

EXPLAIN Select * FROM customers Where customer_id = 9 ;
-- EXPLAIN Select * FROM customers Where state = 'CA' ;
-- CREATE INDEX idx_state ON customers(state);
-- use sql_store;
-- SHOW INDEX IN CUSTOMERS;









