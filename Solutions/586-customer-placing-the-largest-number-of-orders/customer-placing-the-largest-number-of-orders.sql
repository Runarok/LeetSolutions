# Write your MySQL query statement below

-- Solution for exactly one customer with the most orders
SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;
