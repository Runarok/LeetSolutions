-- Delete duplicate records from the 'person' table, keeping only the first occurrence of each email
DELETE p
FROM person p
-- Keep only the row with the smallest 'id' for each email, delete others
WHERE p.id NOT IN (
    -- Subquery: get the minimum 'id' for each unique email
    SELECT MIN(id)
    FROM person
    GROUP BY email
);
/* Write your T-SQL query statement below */
