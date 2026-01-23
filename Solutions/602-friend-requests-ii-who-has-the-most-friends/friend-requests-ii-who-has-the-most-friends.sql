-- Get the user (accepter or requester) with the highest total number of requests
SELECT
    id,                  -- User ID
    SUM(num) AS num      -- Total number of requests involving this user
FROM (
    -- Count requests where the user is the accepter
    SELECT accepter_id AS id, COUNT(*) AS num
    FROM RequestAccepted
    GROUP BY accepter_id

    UNION ALL

    -- Count requests where the user is the requester
    SELECT requester_id AS id, COUNT(*) AS num
    FROM RequestAccepted
    GROUP BY requester_id
) t
-- Sum up counts for users who appear as both requester and accepter
GROUP BY id
-- Order by total number of requests descending
ORDER BY num DESC
-- Only return the top user
LIMIT 1;
