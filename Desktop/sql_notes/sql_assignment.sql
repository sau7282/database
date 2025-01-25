--1. SQL Query to Create the employees Table
CREATE TABLE employees (
emp_
id INT NOT NULL PRIMARY KEY,
emp_
name TEXT NOT NULL,
age INT CHECK (age >= 18),
email TEXT UNIQUE,
salary DECIMAL(10, 2) DEFAULT 30000
);
--2. Purpose of Constraints and Common Types
Constraints enforce rules on the data in a table to maintain data integrity. They prevent invalid data from
being entered into the database.
Examples:
NOT NULL: Ensures a column cannot have NULL values (e.g., emp_name in employees).
PRIMARY KEY: Uniquely identifies each record in a table (e.g., emp_id in employees).
UNIQUE: Ensures all values in a column are unique (e.g., email in employees).
CHECK: Restricts the range of values (e.g., age >= 18).
FOREIGN KEY: Ensures referential integrity between tables.
3. NOT NULL and PRIMARY KEY
●
●
Why NOT NULL?
○
Ensures essential data is not missing.
○
Example: emp_name should never be NULL since an employee must have a name.
Can a PRIMARY KEY contain NULL values?
○
No, a primary key must uniquely identify records and cannot contain NULL values.
○
Reason: NULL means "unknown,
" which violates the uniqueness constraint.
4. Adding and Removing Constraints
Adding a Constraint:
ALTER TABLE employees
ADD CONSTRAINT chk_salary CHECK (salary >= 0);
Removing a Constraint:
ALTER TABLE employees
DROP CONSTRAINT chk_salary;
5. Consequences of Violating Constraints
Attempting to violate constraints results in an error.
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (1,
(2,
'John'
'Jane'
, 25,
, 30,
'john@example.com'
, 40000),
'john@example.com'
, 45000);
6. Modifying products Table
ALTER TABLE products
ADD CONSTRAINT pk
_product
_
id PRIMARY KEY (product
_
id);
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;
7. Query to Fetch student_name and class_name
SELECT s.student_name, c.class_name
FROM Students s
INNER JOIN Classes c ON s.class_id = c.class_id;
8. Query for Orders and Products
SELECT o.order_id, c.customer_name, p.product_name
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;
9. Total Sales Amount for Each Product
SELECT p.product_name, SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;
10. Order Details with Customer Names
SELECT o.order_id, c.customer_name, od.quantity
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id;
=========================================================================
-- 1. Identify the primary keys and foreign keys in the database
SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME,
REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA =
'maven_movies';
-- 2. List all details of actors
SELECT *
FROM actors;
-- 3. List all customer information from DB
SELECT *
FROM customers;
-- 4. List different countries
SELECT DISTINCT country
FROM countries;
-- 5. Display all active customers
SELECT *
FROM customers
WHERE active = 1;
-- 6. List of all rental IDs for customer with ID 1
SELECT rental_id
FROM rentals
WHERE customer_id = 1;
-- 7. Display all the films whose rental duration is greater than 5
SELECT *
FROM films
WHERE rental_duration > 5;
-- 8. List the total number of films whose replacement cost is greater than
$15 and less than $20
SELECT COUNT(*) AS total_films
FROM films
WHERE replacement_cost > 15 AND replacement_cost < 20;
-- 9. Display the count of unique first names of actors
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actors;
-- 10. Display the first 10 records from the customer table
SELECT *
FROM customers
LIMIT 10;
-- 11. Display the first 3 records from the customer table whose first name
starts with 'b'
SELECT *
FROM customers
WHERE first_name LIKE 'b%'
LIMIT 3;
-- 12. Display the names of the first 5 movies which are rated as 'G'
SELECT title
FROM films
WHERE rating =
LIMIT 5;
'G'
-- 13. Find all customers whose first name starts with "a"
SELECT *
FROM customers
WHERE first_name LIKE 'a%';
-- 14. Find all customers whose first name ends with "a"
SELECT *
FROM customers
WHERE first_name LIKE '%a';
-- 15. Display the list of first 4 cities which start and end with 'a'
SELECT DISTINCT city
FROM cities
WHERE city LIKE 'a%' AND city LIKE '%a'
LIMIT 4;
-- 16. Find all customers whose first name has "NI" in any position
SELECT *
FROM customers
WHERE first_name LIKE '%NI%';
-- 17. Find all customers whose first name has "r" in the second position
SELECT *
FROM customers
WHERE first_name LIKE '
_r%';
-- 18. Find all customers whose first name starts with "a" and are at least 5
characters in length
SELECT *
FROM customers
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;
-- 19. Find all customers whose first name starts with "a" and ends with "o"
SELECT *
FROM customers
WHERE first_name LIKE 'a%o';
-- 20. Get the films with PG and PG-13 rating using IN operator
SELECT *
FROM films
WHERE rating IN ('PG'
,
'PG-13');
-- 21. Get the films with length between 50 to 100 using BETWEEN operator
SELECT *
FROM films
WHERE length BETWEEN 50 AND 100;
-- 22. Get the top 50 actors using LIMIT operator
SELECT *
FROM actors
LIMIT 50;
-- 23. Get the distinct film IDs from the inventory table
SELECT DISTINCT film_id
FROM inventory;
===================================================
-- Basic Aggregate Functions:
-- Question 1: Retrieve the total number of rentals made in the Sakila
database.
SELECT COUNT(*) AS total_rentals
FROM rental;
-- Question 2: Find the average rental duration (in days) of movies rented
from the Sakila database.
SELECT AVG(DATEDIFF(return_date, rental_date)) AS average_rental_duration
FROM rental;
-- String Functions:
-- Question 3: Display the first name and last name of customers in uppercase.
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS
last_name_upper
FROM customer;
-- Question 4: Extract the month from the rental date and display it alongside
the rental ID.
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;
-- GROUP BY:
-- Question 5: Retrieve the count of rentals for each customer (display
customer ID and the count of rentals).
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;
-- Question 6: Find the total revenue generated by each store.
SELECT store_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;
-- Question 7: Determine the total number of rentals for each category of
movies.
SELECT c.name AS category_name, COUNT(*) AS rental_count
FROM film_category fc
LEFT JOIN category c ON fc.category_id = c.category_id
LEFT JOIN inventory i ON fc.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;
-- Question 8: Find the average rental rate of movies in each language.
SELECT l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate
FROM film f
LEFT JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;
-- JOINs:
-- Question 9: Display the title of the movie, customer's first name, and last
name who rented it.
SELECT f.title, c.first_name, c.last_name
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN customer c ON r.customer_id = c.customer_id;
-- Question 10: Retrieve the names of all actors who have appeared in the film
"Gone with the Wind.
"
SELECT a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
WHERE f.title =
'Gone with the Wind';
-- Question 11: Retrieve the customer names along with the total amount
they've spent on rentals.
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;
-- Question 12: List the titles of movies rented by each customer in a
particular city (e.g.,
'London').
SELECT c.first_name, c.last_name, f.title
FROM customer c
LEFT JOIN address a ON c.address_id = a.address_id
LEFT JOIN city ci ON a.city_id = ci.city_id
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN film f ON i.film_id = f.film_id
WHERE ci.city =
'London'
GROUP BY c.customer_id, f.film_id;
-- Advanced JOINs and GROUP BY:
-- Question 13: Display the top 5 rented movies along with the number of times
they've been rented.
SELECT f.title, COUNT(*) AS rental_count
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;
-- Question 14: Determine the customers who have rented movies from both
stores (store ID 1 and store ID 2).
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id = 1
AND c.customer_id IN (
SELECT c2.customer_id
FROM customer c2
LEFT JOIN rental r2 ON c2.customer_id = r2.customer_id
LEFT JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
WHERE i2.store_id = 2
)
GROUP BY c.customer_id;
===========================================================================
-- 1. Rank the customers based on the total amount they've spent on rentals.
SELECT
customer_id,
SUM(amount) AS total_spent,
RANK() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM payment
GROUP BY customer_id;
-- 2. Calculate the cumulative revenue generated by each film over time.
SELECT
f.title,
r.rental_date,
cumulative_revenue
SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN payment p ON r.rental_id = p.rental_id;
-- 3. Determine the average rental duration for each film, considering films
with similar lengths.
SELECT
f.film_id,
f.title,
AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration,
AVG(DATEDIFF(r.return_date, r.rental_date)) OVER (PARTITION BY f.length)
AS avg_duration_similar_length
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id;
-- 4. Identify the top 3 films in each category based on their rental counts.
SELECT
c.name AS category_name,
f.title,
COUNT(r.rental_id) AS rental_count,
RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, f.title
HAVING rank <= 3;
-- 5. Calculate the difference in rental counts between each customer's total
rentals and the average rentals across all customers.
SELECT
customer_id,
COUNT(r.rental_id) AS customer_rental_count,
AVG(COUNT(r.rental_id)) OVER () AS avg_rental_count,
COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER () AS rental_count_diff
FROM rental r
GROUP BY customer_id;
-- 6. Find the monthly revenue trend for the entire rental store over time.
SELECT
DATE_FORMAT(r.rental_date,
'%Y-%m') AS month,
SUM(p.amount) AS total_revenue,
SUM(SUM(p.amount)) OVER (ORDER BY DATE_FORMAT(r.rental_date,
cumulative_revenue
FROM rental r
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY DATE_FORMAT(r.rental_date,
'%Y-%m');
'%Y-%m')) AS
-- 7. Identify the customers whose total spending on rentals falls within the
top 20% of all customers.
WITH CustomerSpending AS (
SELECT
customer_id,
SUM(amount) AS total_spent,
PERCENT_RANK() OVER (ORDER BY SUM(amount) DESC) AS percent_rank
FROM payment
GROUP BY customer_id
)
SELECT customer_id, total_spent
FROM CustomerSpending
WHERE percent_rank >= 0.8;
-- 8. Calculate the running total of rentals per category, ordered by rental
count.
SELECT
c.name AS category_name,
f.title,
COUNT(r.rental_id) AS rental_count,
SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.name ORDER BY
COUNT(r.rental_id) DESC) AS running_total
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, f.title;
-- 9. Find the films that have been rented less than the average rental count
for their respective categories.
WITH CategoryAvg AS (
SELECT
c.name AS category_name,
f.film_id,
COUNT(r.rental_id) AS rental_count,
AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.name) AS
avg_category_rentals
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, f.film_id
)
SELECT film_id, category_name, rental_count
FROM CategoryAvg
WHERE rental_count < avg_category_rentals;
-- 10. Identify the top 5 months with the highest revenue and display the
revenue generated in each month.
SELECT
DATE_FORMAT(r.rental_date,
'%Y-%m') AS month,
SUM(p.amount) AS total_revenue
FROM rental r
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY DATE_FORMAT(r.rental_date,
'%Y-%m')
ORDER BY total_revenue DESC
LIMIT 5;
=========================================
-- 1. First Normal Form (1NF):
-- Violation: A table violates 1NF if it contains repeating groups or arrays.
-- Example: A column with multiple phone numbers per actor in the
`
`
actor
table.
-- Solution: Create a new table
`
actor_phones
`
with `
actor_id`
and
`
phone_number
`
.
-- 2. Second Normal Form (2NF):
-- Violation: A table violates 2NF if it is in 1NF but has partial
dependencies.
-- Example: In
`film_actor
`
,
the composite key (`film_id`
,
`film_title
`
actor_id`).
and `
actor_name
`
` depend on part of
-- Solution: Split the table into
`
actor_id`),
`film
` (with `film_id`
-- and `
actor
` (with `
actor_id`
and `
`film_actor
` (with composite key
and `film_title
`).
`),
actor_name
`film_id`
,
-- 3. Third Normal Form (3NF):
-- Violation: A table violates 3NF if it is in 2NF but has transitive
dependencies.
-- Example:
`
in
`
customer
store_location
` depends on
`
store_id`
, which is not a primary key
` table.
-- Solution: Split into
`
customer
`
store_id`) and `
store
` (with `
` (with `
store_id`
,
customer_id`
,
`
customer_name
`
,
`
store_location
`).
-- 4. Normalization Process:
-- Example:
`
payment_date
`
payment` table with `
store_id`
payment_id`
,
`
customer_id`
`
amount`
,
,
`
`
,
.
-- Step-by-step normalization:
-- 1NF: Ensure atomic values (split multi-valued columns).
-- 2NF: Remove partial dependencies (ensure non-prime attributes depend on the
full key).
-- 3NF: Eliminate transitive dependencies (non-prime attributes should depend
only on the key).
-- 5. CTE Basics: Get distinct actor names and their film counts.
WITH actor_film_count AS (
SELECT actor_id, COUNT(*) AS film_count
FROM film_actor
GROUP BY actor_id
)
SELECT a.first_name, a.last_name, af.film_count
FROM actor a
JOIN actor_film_count af ON a.actor_id = af.actor_id;
-- 6. CTE with Joins: Get film title, language name, and rental rate.
WITH film_language AS (
SELECT f.film_id, f.title AS film_title, l.name AS language_name,
f.rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_language;
-- 7. CTE for Aggregation: Find total revenue per customer.
WITH customer_revenue AS (
SELECT customer_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY customer_id
)
SELECT c.first_name, c.last_name, cr.total_revenue
FROM customer c
JOIN customer_revenue cr ON c.customer_id = cr.customer_id;
-- 8. CTE with Window Functions: Rank films by rental duration.
WITH film_ranking AS (
SELECT title, rental_duration, RANK() OVER (ORDER BY rental_duration DESC)
AS rental_rank
FROM film
)
SELECT * FROM film_ranking;
-- 9. CTE and Filtering: List customers who have made more than two rentals.
WITH customer_rentals AS (
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 2
)
SELECT c.first_name, c.last_name
FROM customer c
JOIN customer_rentals cr ON c.customer_id = cr.customer_id;
-- 10. CTE for Date Calculations: Total rentals per month.
WITH monthly_rentals AS (
SELECT EXTRACT(MONTH FROM rental_date) AS month, COUNT(*) AS rental_count
FROM rental
GROUP BY EXTRACT(MONTH FROM rental_date)
)
SELECT month, rental_count FROM monthly_rentals;
-- 11. CTE and Self-Join: Get pairs of actors who have appeared in the same
film.
WITH actor_pairs AS (
SELECT fa1.actor_id AS actor1_id, fa2.actor_id AS actor2_id, fa1.film_id
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
WHERE fa1.actor_id < fa2.actor_id
)
SELECT a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name
FROM actor_pairs ap
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id;
-- 12. CTE for Recursive Search: Find employees reporting to a specific
manager.
WITH RECURSIVE employee_hierarchy AS (
SELECT staff_id, first_name, last_name, reports_to
FROM staff
WHERE reports_to IS NULL
UNION ALL
SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
FROM staff s
JOIN employee_hierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM employee_hierarchy;