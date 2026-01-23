-- Select employee ID and department ID from the Employee table
SELECT employee_id, department_id  

-- From the Employee table
FROM Employee  

-- Filter rows based on two conditions:
-- 1) The employee is marked as primary
-- 2) OR the employee appears only once in the Employee table
WHERE primary_flag = 'Y'           -- Include employees where primary_flag is 'Y'
   OR employee_id IN (             -- OR include employees whose ID appears only once
       SELECT employee_id
       FROM Employee
       GROUP BY employee_id        -- Group by employee_id to count occurrences
       HAVING COUNT(employee_id) = 1  -- Keep only employee IDs that appear exactly once
   );

-- Explanation:
-- 1. primary_flag = 'Y' selects all employees marked as primary in their department
-- 2. The subquery finds employees who only exist in one record (not repeated across departments)
-- 3. OR combines the two criteria, so an employee is selected if either condition is true
-- 4. Result: returns employee_id and department_id for primary employees or those appearing only once
