-- Select columns from the Employees and EmployeeUNI tables
SELECT euni.unique_id,  -- Select the unique_id column from EmployeeUNI table (alias euni)
       e.name           -- Select the name column from Employees table (alias e)

-- From the Employees table
FROM Employees e         -- Use 'e' as an alias for the Employees table

-- Perform a LEFT JOIN with EmployeeUNI table
LEFT JOIN EmployeeUNI euni  -- Use 'euni' as an alias for EmployeeUNI table

-- Define the condition to match rows between Employees and EmployeeUNI
ON e.id = euni.id        -- Join where the id in Employees matches the id in EmployeeUNI

-- Explanation:
-- 1. LEFT JOIN ensures all rows from Employees (left table) are returned
-- 2. If there is no matching row in EmployeeUNI, unique_id will be NULL
-- 3. The result shows the employee name along with their unique_id if it exists
