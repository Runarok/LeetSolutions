-- Select the department ID and pivot monthly revenue into separate columns
SELECT id,  

       -- For each month, get the revenue if the month matches, otherwise NULL
       MAX(IF(month = "Jan", revenue, NULL)) AS Jan_Revenue,   -- January revenue
       MAX(IF(month = "Feb", revenue, NULL)) AS Feb_Revenue,   -- February revenue
       MAX(IF(month = "Mar", revenue, NULL)) AS Mar_Revenue,   -- March revenue
       MAX(IF(month = "Apr", revenue, NULL)) AS Apr_Revenue,   -- April revenue
       MAX(IF(month = "May", revenue, NULL)) AS May_Revenue,   -- May revenue
       MAX(IF(month = "Jun", revenue, NULL)) AS Jun_Revenue,   -- June revenue
       MAX(IF(month = "Jul", revenue, NULL)) AS Jul_Revenue,   -- July revenue
       MAX(IF(month = "Aug", revenue, NULL)) AS Aug_Revenue,   -- August revenue
       MAX(IF(month = "Sep", revenue, NULL)) AS Sep_Revenue,   -- September revenue
       MAX(IF(month = "Oct", revenue, NULL)) AS Oct_Revenue,   -- October revenue
       MAX(IF(month = "Nov", revenue, NULL)) AS Nov_Revenue,   -- November revenue
       MAX(IF(month = "Dec", revenue, NULL)) AS Dec_Revenue    -- December revenue

-- From the Department table
FROM Department  

-- Group by department ID to get one row per department
GROUP BY id  

-- Order the results by department ID ascending
ORDER BY id;  

-- Explanation:
-- 1. IF(month = "X", revenue, NULL) checks if the row corresponds to month X, else returns NULL
-- 2. MAX(...) is used to collapse multiple rows into one per department (since only one non-NULL value exists per month)
-- 3. This effectively "pivots" rows of monthly revenue into columns
-- 4. GROUP BY id ensures one row per department
-- 5. ORDER BY id sorts the departments in ascending order
