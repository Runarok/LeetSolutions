-- Count the number of followers for each user
SELECT
    user_id,                -- ID of the user
    COUNT(follower_id) AS followers_count  -- Number of followers the user has
FROM Followers
-- Group by user to aggregate their followers
GROUP BY user_id
-- Order results by user_id
ORDER BY user_id;
