-- Select event day, employee ID, and total time worked
SELECT 
    event_day AS day,               -- Rename event_day column as 'day'
    emp_id,                         -- Include the employee ID
    SUM(out_time - in_time) AS total_time  -- Calculate total time worked per employee per day

-- From the Employees table
FROM Employees

-- Group the results by day and employee to aggregate total time
GROUP BY 1, 2                       -- 1 refers to the first column (day), 2 refers to the second column (emp_id)

-- Explanation:
-- 1. out_time - in_time calculates the duration of each work session
-- 2. SUM(...) aggregates all durations for a specific employee on a specific day
-- 3. GROUP BY 1, 2 groups the data by event_day and emp_id (using positional notation)
-- 4. The result: for each employee and each day, shows total hours worked
