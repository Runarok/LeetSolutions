-- Step 1: Use a CTE (Common Table Expression) to rank salaries in each department
WITH RankedSalaries AS (
    SELECT
        e.id,                -- Employee ID
        e.name AS Employee,  -- Employee name
        e.salary,            -- Employee salary
        d.name AS Department, -- Department name from Department table
        -- Use DENSE_RANK to rank salaries per department
        -- DENSE_RANK ensures that employees with the same salary get the same rank
        DENSE_RANK() OVER (
            PARTITION BY e.departmentId  -- Separate ranking per department
            ORDER BY e.salary DESC        -- Highest salary gets rank 1
        ) AS salary_rank
    FROM Employee e
    JOIN Department d
        ON e.departmentId = d.id  -- Join to get department names
)

-- Step 2: Filter for only the top 3 unique salaries per department
SELECT 
    Department,
    Employee,
    salary
FROM RankedSalaries
WHERE salary_rank <= 3  -- Only include employees in the top 3 salaries
-- Alternative: If you want the third highest salary only, use salary_rank = 3

-- Optional: Sort the result
ORDER BY Department, salary DESC, Employee ASC;

