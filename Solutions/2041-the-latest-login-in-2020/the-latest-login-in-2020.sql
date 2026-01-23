-- Select each user and their latest login timestamp in 2020
SELECT DISTINCT(user_id),           -- Get unique user IDs
       MAX(time_stamp) AS last_stamp  -- Find the latest login timestamp per user in 2020

-- From the Logins table
FROM Logins  

-- Filter only logins that occurred in the year 2020
WHERE EXTRACT(YEAR FROM time_stamp) = 2020  

-- Group by user_id to get one row per user
GROUP BY user_id  

-- Order the result by the latest login timestamp, descending (most recent first)
ORDER BY last_stamp DESC;  

-- Explanation:
-- 1. DISTINCT(user_id) ensures each user appears only once
-- 2. MAX(time_stamp) finds the latest login for each user
-- 3. WHERE EXTRACT(YEAR FROM time_stamp) = 2020 limits the data to the year 2020
-- 4. GROUP BY user_id aggregates the data per user
-- 5. ORDER BY last_stamp DESC sorts users by most recent login first
