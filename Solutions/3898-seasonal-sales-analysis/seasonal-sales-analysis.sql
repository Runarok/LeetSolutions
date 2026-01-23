-- Step 1: Assign a season to each sale based on the month of sale_date
WITH season_table AS (
    SELECT 
        CASE
            WHEN MONTH(sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(sale_date) IN (6, 7, 8) THEN 'Summer'
            WHEN MONTH(sale_date) IN (9, 10, 11) THEN 'Fall'
        END AS season,
        product_id,
        quantity,
        price
    FROM sales
),

-- Step 2: Aggregate sales by season and product category
temp_table AS (
    SELECT
        s.season,
        p.category,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM season_table s
    JOIN products p
        ON s.product_id = p.product_id
    GROUP BY s.season, p.category
),

-- Step 3: Rank categories within each season by total quantity and then by revenue
rank_table AS (
    SELECT 
        RANK() OVER (
            PARTITION BY season 
            ORDER BY total_quantity DESC, total_revenue DESC
        ) AS rnk,
        season,
        category,
        total_quantity,
        total_revenue
    FROM temp_table
)

-- Step 4: Select only the top-ranked category for each season
SELECT 
    season,
    category,
    total_quantity,
    total_revenue
FROM rank_table
WHERE rnk = 1
ORDER BY season;
