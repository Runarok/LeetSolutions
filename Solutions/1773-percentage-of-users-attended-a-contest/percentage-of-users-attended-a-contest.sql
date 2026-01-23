-- Step 1: Count total users
WITH total_users AS (
    SELECT COUNT(*) AS cnt
    FROM Users
)

-- Step 2: Count registered users per contest
, contest_counts AS (
    SELECT
        contest_id,
        COUNT(DISTINCT user_id) AS registered_users
    FROM Register
    GROUP BY contest_id
)

-- Step 3: Compute percentage of registered users per contest
SELECT
    c.contest_id,
    ROUND(c.registered_users / t.cnt * 100, 2) AS percentage
FROM contest_counts c
CROSS JOIN total_users t            -- To get the total number of users for percentage calculation
ORDER BY 
    percentage DESC,               -- Descending percentage
    contest_id ASC;                -- Ascending contest_id in case of tie
