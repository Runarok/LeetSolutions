-- Find the largest number that appears only once in the table
SELECT 
    MAX(num) AS num
FROM (
    -- Select numbers that occur exactly once
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) t;
