-- Outer query: Select all columns from a derived table 'tt'
SELECT *
FROM (
    -- Derived table 'tt': aggregate the average durations per user
    SELECT 
        t.user_id AS user_id,                         -- Select the user ID
        ROUND(SUM(trial_avg_duration), 2) AS trial_avg_duration, -- Sum trial durations and round to 2 decimals
        ROUND(SUM(paid_avg_duration), 2) AS paid_avg_duration    -- Sum paid durations and round to 2 decimals
    FROM (
        -- Inner query 't': calculate average activity duration per user per activity type
        SELECT 
            user_id,                                   -- Select the user ID
            -- Average duration for free_trial activities; 0 if not free_trial
            AVG(IF(activity_type = 'free_trial', activity_duration, 0)) AS trial_avg_duration,  
            -- Average duration for paid activities; 0 if not paid
            AVG(IF(activity_type = 'paid', activity_duration, 0)) AS paid_avg_duration
        FROM UserActivity
        GROUP BY user_id, activity_type               -- Group by user and activity type to get averages
    ) AS t
    GROUP BY t.user_id                               -- Aggregate the inner results by user_id
) AS tt
-- Filter users who have a non-zero paid activity average
WHERE tt.paid_avg_duration != 0
-- Order the results by user_id in ascending order
ORDER BY tt.user_id ASC;

-- Explanation Summary:
-- 1. Inner query: calculates average durations per activity type for each user
-- 2. Middle query: sums those averages per user and rounds to 2 decimals
-- 3. Outer query: filters out users who never had paid activities
-- 4. Result: List of users with trial and paid average durations, only including users with paid activity
