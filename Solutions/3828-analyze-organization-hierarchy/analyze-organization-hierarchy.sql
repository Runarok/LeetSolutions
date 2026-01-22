-- This query calculates a hierarchical view of employees, including:
-- 1. Their level in the organization
-- 2. The total size of their reporting team (direct and indirect reports)
-- 3. The total budget they are responsible for (their salary + team salaries)

-- Step 1: Build the hierarchical structure of employees
WITH RECURSIVE Hierarchy AS (
    -- Base case: Select top-level employees (those without a manager)
    SELECT 
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level -- Level 1 indicates top-level
    FROM employees 
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: Get employees reporting to the current hierarchy
    SELECT 
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        h.level + 1 -- Increase level for subordinates
    FROM employees e
    JOIN Hierarchy h ON e.manager_id = h.employee_id
    -- Alternative: You could also calculate a 'path' to show reporting line
    -- e.g., CONCAT(h.employee_name, ' > ', e.employee_name) AS reporting_path
),

-- Step 2: Build a list of all subordinates for each manager
Subordinates AS (
    -- Direct subordinates
    SELECT 
        manager_id,
        employee_id AS subordinate_id 
    FROM employees 
    WHERE manager_id IS NOT NULL
    
    UNION ALL 
    
    -- Recursive case: indirect subordinates
    SELECT 
        s.manager_id, 
        e.employee_id 
    FROM Subordinates s
    JOIN employees e ON e.manager_id = s.subordinate_id
    -- Alternative: Could include level of subordination as well
    -- e.g., s.level + 1 AS sub_level
),

-- Step 3: Aggregate stats for each manager
ManagerStats AS (
    SELECT 
        s.manager_id,
        COUNT(*) AS team_size,         -- Total number of subordinates
        SUM(e.salary) AS team_salary   -- Total salary of team
    FROM Subordinates s
    JOIN employees e ON s.subordinate_id = e.employee_id
    GROUP BY s.manager_id
    -- Alternative: Could also calculate average salary
    -- AVG(e.salary) AS avg_team_salary
),

-- Step 4: Combine hierarchy with manager stats to compute budget
FinalResult AS (
    SELECT 
        h.employee_id,
        h.employee_name,
        h.level,
        COALESCE(ms.team_size, 0) AS team_size,           -- Ensure managers with no subordinates show 0
        h.salary + COALESCE(ms.team_salary, 0) AS budget -- Total budget responsibility
    FROM Hierarchy h
    LEFT JOIN ManagerStats ms ON h.employee_id = ms.manager_id
    -- Alternative: Could use INNER JOIN if you only want managers with teams
)

-- Step 5: Select final result
SELECT *
FROM FinalResult
ORDER BY 
    level ASC,          -- First by hierarchy level
    budget DESC,        -- Then by total budget descending
    employee_name ASC;  -- Finally alphabetically by name
