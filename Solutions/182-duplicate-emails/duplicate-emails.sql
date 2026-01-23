-- Select emails that appear more than once in the Person table
SELECT email  

-- From the Person table
FROM Person  

-- Group the results by email to count duplicates
GROUP BY email  

-- Only include emails that appear more than once
HAVING COUNT(email) > 1;  

-- Explanation:
-- 1. GROUP BY email groups all rows with the same email together
-- 2. COUNT(email) counts how many times each email appears
-- 3. HAVING COUNT(email) > 1 filters to keep only duplicate emails
-- 4. Result: a list of emails that are not unique in the Person table
