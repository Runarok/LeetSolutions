# Write your MySQL query statement below

WITH cte AS (
    SELECT *,
           LEAD(people, 1) OVER (ORDER BY id) AS next1,
           LEAD(people, 2) OVER (ORDER BY id) AS next2,
           LAG(people, 1) OVER (ORDER BY id) AS prev1,
           LAG(people, 2) OVER (ORDER BY id) AS prev2
    FROM Stadium
)
SELECT id, visit_date, people
FROM cte
WHERE people >= 100
  AND (
       (people >= 100 AND next1 >= 100 AND next2 >= 100)   -- start of a sequence
    OR (prev1 >= 100 AND people >= 100 AND next1 >= 100)  -- middle of a sequence
    OR (prev2 >= 100 AND prev1 >= 100 AND people >= 100)  -- end of a sequence
  )
ORDER BY visit_date;
