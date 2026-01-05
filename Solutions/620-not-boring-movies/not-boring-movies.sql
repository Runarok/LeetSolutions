# Write your MySQL query statement below

SELECT *
FROM Cinema
WHERE id % 2 = 1            -- odd-numbered IDs
  AND description <> 'boring' -- description is not "boring"
ORDER BY rating DESC;        -- sort by rating descending
