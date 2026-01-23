-- Select all columns and determine if the three sides can form a triangle
SELECT *,  

       -- Check the triangle inequality theorem:
       -- If the sum of any two sides is greater than the third side, it's a valid triangle
       IF(x + y > z AND y + z > x AND x + z > y, "Yes", "No") AS triangle  

-- From the 'triangle' table
FROM triangle;  

-- Explanation:
-- 1. SELECT *                  -> Returns all existing columns (x, y, z) from the table
-- 2. IF(condition, "Yes","No") -> Evaluates the triangle inequality:
--    - x + y > z
--    - y + z > x
--    - x + z > y
--    If all conditions are true, output "Yes"; otherwise "No"
-- 3. AS triangle               -> Names the calculated column as 'triangle'
-- 4. FROM triangle             -> Specifies the table containing the side lengths
-- Result: For each row, shows sides and whether they can form a triangle
