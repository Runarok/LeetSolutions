-- Calculate the average experience years of employees for each project
SELECT
    p.project_id,                                      -- Project ID
    ROUND(AVG(e.experience_years), 2) AS average_years  -- Average experience rounded to 2 decimal places
FROM Project p
-- Join with Employee table to get the experience of each employee in the project
JOIN Employee e ON p.employee_id = e.employee_id
-- Group by project to compute the average per project
GROUP BY p.project_id;
