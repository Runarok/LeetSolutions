-- Select employee names and their bonus amounts
SELECT e.name,          -- Get the employee name from the 'employee' table (alias e)
       b.bonus          -- Get the bonus amount from the 'bonus' table (alias b)

-- From the 'employee' table
FROM employee e         -- 'e' is an alias for the employee table

-- Perform a LEFT JOIN to include all employees, even if they have no bonus record
LEFT JOIN bonus b       -- 'b' is an alias for the bonus table
    ON e.empId = b.empId  -- Join on employee ID to match bonus records to employees

-- Filter results to show only employees with a bonus less than 1000, or no bonus at all
WHERE b.bonus < 1000    -- Include employees whose bonus is less than 1000
   OR b.bonus IS NULL   -- Include employees who have no bonus record (NULL)

-- Explanation:
-- 1. LEFT JOIN ensures all employees are included, even if they do not have a bonus
-- 2. WHERE b.bonus < 1000 OR b.bonus IS NULL filters for small or missing bonuses
-- 3. The result lists employee names and their corresponding bonuses (or NULL if none)
-- 4. Useful for identifying employees with low or no bonus
