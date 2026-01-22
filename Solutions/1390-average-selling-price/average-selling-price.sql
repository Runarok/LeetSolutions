-- Step 1: Aggregate total revenue and total units sold for each product
WITH total_sales AS (
    SELECT
        u.product_id,                            -- the product identifier
        SUM(u.units * p.price) AS total_price,   -- total money earned from this product
        SUM(u.units) AS total_units              -- total units sold for this product
    FROM UnitsSold u
    JOIN Prices p
        ON u.product_id = p.product_id           -- match product IDs between sales and prices
       AND u.purchase_date BETWEEN p.start_date AND p.end_date  -- ensure sale falls within price validity
    GROUP BY u.product_id                         -- group by product to calculate totals per product
)
-- Step 2: Calculate average selling price per product
SELECT
    p.product_id,                                 -- output product ID
    ROUND(
        COALESCE(ts.total_price / ts.total_units, 0), 2  -- calculate average price, 0 if no sales, round to 2 decimals
    ) AS average_price
FROM (SELECT DISTINCT product_id FROM Prices) p  -- list all unique products from Prices table
LEFT JOIN total_sales ts
    ON p.product_id = ts.product_id               -- bring in aggregated sales data, may be NULL if no sales
ORDER BY p.product_id;                            -- optional: sort results by product ID
