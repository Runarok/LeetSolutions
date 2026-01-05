# Write your MySQL query statement below

SELECT e.employee_id
FROM Employees e
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL      -- ensure they have a manager assigned
  AND e.manager_id NOT IN (          -- check if manager has left
        SELECT employee_id
        FROM Employees
  )
ORDER BY e.employee_id;
