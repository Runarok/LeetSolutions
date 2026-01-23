-- Update the 'salary' table
UPDATE salary  

-- Set the 'sex' column to a new value based on a condition
SET sex =  

    -- Start a CASE expression to determine what value to assign
    CASE sex  

        -- If the current value of 'sex' is 'm'
        WHEN 'm' THEN 'f'  
        -- Then change it to 'f' (flip male to female)

        -- For all other values (including 'f' or null)
        ELSE 'm'  
        -- Change it to 'm' (flip female or anything else to male)

    -- End of CASE expression
    END;  

-- Explanation:
-- 1. UPDATE salary              -> We're modifying data in the salary table
-- 2. SET sex = CASE ... END      -> We assign a new value to the 'sex' column
-- 3. CASE sex                    -> Evaluate the current value of 'sex'
-- 4. WHEN 'm' THEN 'f'           -> If male, make female
-- 5. ELSE 'm'                     -> Otherwise, make male
-- 6. END                         -> Close the CASE expression
-- 7. Semicolon (;)                -> End of SQL statement

-- Notes:
-- - This flips 'm' to 'f' and everything else (like 'f' or null) to 'm'
-- - Works for all rows in the salary table because no WHERE clause is specified
-- - Be careful: this updates the entire table!
