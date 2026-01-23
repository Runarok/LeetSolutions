-- Find the first login date for each player
SELECT
    player_id,                -- ID of the player
    MIN(event_date) AS first_login  -- Earliest login date for the player
FROM Activity
-- Group by player to get the minimum date per player
GROUP BY player_id;
