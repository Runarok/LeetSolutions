-- Select the names of customers who have never placed an order
SELECT name AS Customers    -- Get the customer's name and rename the column as 'Customers'

-- From the Customers table
FROM Customers  

-- Perform a LEFT JOIN with the Orders table to include all customers
LEFT JOIN Orders ON Customers.id = Orders.customerId  
-- Join on Customers.id = Orders.customerId to match orders to customers

-- Filter to keep only customers who do NOT have a matching order
WHERE Orders.customerId IS NULL  
-- If there is no order for a customer, Orders.customerId will be NULL
-- This ensures only customers with zero orders are selected
