-- Find all salespersons who did NOT have any orders for the company named 'RED'
SELECT sp.name
FROM SalesPerson sp
WHERE sp.sales_id NOT IN (
    -- Subquery: get all sales_ids who have orders with company 'RED'
    SELECT o.sales_id
    FROM Orders o
    JOIN Company c ON o.com_id = c.com_id
    WHERE c.name = 'RED'
);
