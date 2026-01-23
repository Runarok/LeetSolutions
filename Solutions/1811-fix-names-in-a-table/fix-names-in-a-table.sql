-- Step 1: Fix the names so only the first character is uppercase and the rest lowercase
SELECT
    user_id,
    -- CONCAT: combine the first letter uppercased and the rest lowercased
    CONCAT(
        UPPER(SUBSTRING(name, 1, 1)),      -- First character uppercase
        LOWER(SUBSTRING(name, 2))          -- Rest of the string lowercase
    ) AS name
FROM Users
ORDER BY user_id;                        -- Return results ordered by user_id
