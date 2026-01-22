-- Create a user-defined function to get the Nth highest salary
CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    -- Declare a variable to store the resulting salary
    DECLARE @salary FLOAT;

    -- Use a Common Table Expression (CTE) to rank distinct salaries
    WITH a AS (
        SELECT DISTINCT salary,
               DENSE_RANK() OVER (ORDER BY salary DESC) AS rn  -- Rank salaries from highest to lowest
        FROM Employee
    )
    -- Select the salary with rank = N into the variable
    SELECT @salary = MAX(salary)  -- MAX is used here, could also use MIN since rn is unique
    FROM a
    WHERE rn = @N;

    -- Return the nth highest salary, or NULL if it doesn't exist
    RETURN @salary;
END;
