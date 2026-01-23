-- Count of accounts grouped by income categories

-- Low Salary category: income less than 20,000
SELECT
    'Low Salary' AS category,                     -- Label for the category
    COUNT(CASE WHEN income < 20000 THEN 1 END) AS accounts_count  -- Number of accounts in this category
FROM accounts

UNION ALL

-- Average Salary category: income between 20,000 and 50,000
SELECT
    'Average Salary' AS category,                -- Label for the category
    COUNT(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 END) AS accounts_count  -- Count of accounts in this range
FROM accounts

UNION ALL

-- High Salary category: income greater than 50,000
SELECT
    'High Salary' AS category,                   -- Label for the category
    COUNT(CASE WHEN income > 50000 THEN 1 END) AS accounts_count  -- Number of accounts above 50,000
FROM accounts;
