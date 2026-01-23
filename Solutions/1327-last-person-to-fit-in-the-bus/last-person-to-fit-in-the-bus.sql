-- Find the last person in the queue whose cumulative weight does not exceed 1000
SELECT person_name
FROM (
    -- Calculate cumulative sum of weights in queue order
    SELECT 
        person_name,
        turn,
        SUM(weight) OVER (ORDER BY turn) AS cum
    FROM queue
) p1
-- Filter only those whose cumulative sum is <= 1000
WHERE cum <= 1000
-- Get the last person by turn among the filtered rows
ORDER BY turn DESC
LIMIT 1;
