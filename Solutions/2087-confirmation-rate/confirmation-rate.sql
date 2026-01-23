-- Step 1: Count total confirmations and confirmed actions per user
WITH confirmation_counts AS (
    SELECT
        user_id,
        COUNT(*) AS total_requests,                          -- Total number of confirmation messages requested
        SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) AS confirmed_count  -- Number of confirmed messages
    FROM Confirmations
    GROUP BY user_id
)

-- Step 2: Join with Signups to include users with no confirmation requests
SELECT
    s.user_id,
    -- Compute confirmation rate as confirmed / total requests
    -- If the user has no requests, use 0
    ROUND(
        COALESCE(c.confirmed_count, 0) / 
        COALESCE(c.total_requests, 1) * IF(c.total_requests IS NULL, 0, 1)
    , 2) AS confirmation_rate
FROM Signups s
LEFT JOIN confirmation_counts c
    ON s.user_id = c.user_id;
