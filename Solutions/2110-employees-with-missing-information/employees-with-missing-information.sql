-- Select employee IDs from Employees who do NOT have a corresponding record in Salaries
SELECT employee_id
FROM Employees
WHERE employee_id NOT IN (SELECT employee_id FROM Salaries)  

-- UNION to combine with employee IDs from Salaries who do NOT have a corresponding record in Employees
UNION  
SELECT employee_id
FROM Salaries
WHERE employee_id NOT IN (SELECT employee_id FROM Employees)  

-- Order the final combined result by employee_id
ORDER BY employee_id;  

-- Explanation:
-- 1. The first SELECT finds employees that exist in Employees but not in Salaries
-- 2. The second SELECT finds employees that exist in Salaries but not in Employees
-- 3. UNION merges the two sets and automatically removes duplicates
-- 4. ORDER BY ensures the output is sorted by employee_id
-- 5. Result: a complete list of employee_ids that are missing in either table
