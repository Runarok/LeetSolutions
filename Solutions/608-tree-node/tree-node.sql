# Write your MySQL query statement below

SELECT 
    t.id,
    CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN c.id IS NULL THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t
LEFT JOIN Tree c 
    ON t.id = c.p_id
GROUP BY t.id, t.p_id
ORDER BY t.id;
