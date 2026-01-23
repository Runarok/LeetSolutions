-- Select the sell_date and aggregate information about products sold on that date
SELECT sell_date,  

       -- Count the number of distinct products sold on each sell_date
       COUNT(DISTINCT product) AS num_sold,  

       -- Concatenate all distinct product names sold on that date into a single string
       -- Ordered alphabetically and separated by commas
       GROUP_CONCAT(DISTINCT product 
                    ORDER BY product ASC 
                    SEPARATOR ',') AS products  

-- From the Activities table
FROM Activities  

-- Group the results by sell_date so aggregates are calculated per day
GROUP BY sell_date  

-- Order the final result by sell_date in ascending order
ORDER BY sell_date ASC;  

-- Explanation per line:
-- 1. sell_date               -> Shows the date of each sale
-- 2. COUNT(DISTINCT product) -> Counts how many unique products were sold on that date
-- 3. GROUP_CONCAT(...)       -> Combines the names of all distinct products into a comma-separated list
-- 4. FROM Activities         -> The table where sales records are stored
-- 5. GROUP BY sell_date      -> Aggregates data for each individual date
-- 6. ORDER BY sell_date ASC  -> Ensures the results are listed from earliest to latest date
