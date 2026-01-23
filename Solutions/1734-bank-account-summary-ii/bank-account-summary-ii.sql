-- Select the user's name and the total transaction amount (balance)
SELECT u.name,                -- Get the name of the user from the 'users' table
       SUM(t.amount) AS balance  -- Calculate the sum of all transaction amounts for that user and name it 'balance'

-- From the 'users' table
FROM users u                  -- Use 'u' as an alias for the 'users' table

-- Join the 'transactions' table to get transaction amounts
LEFT JOIN transactions t      -- Use 't' as an alias for 'transactions'
    ON u.account = t.account  -- Match each user to transactions with the same account number

-- Group results by user name to calculate the sum per user
GROUP BY u.name               -- Aggregate all transactions for each user by name

-- Only show users whose total transaction amount exceeds 10,000
HAVING SUM(t.amount) > 10000  -- Filter aggregated results, keeping only users with balance > 10,000

-- Explanation:
-- 1. LEFT JOIN ensures all users are included, even if they have no transactions
-- 2. SUM(t.amount) adds up the transaction amounts for each user
-- 3. GROUP BY u.name is required because we are using SUM() to aggregate
-- 4. HAVING is used instead of WHERE to filter after aggregation
-- 5. Result: list of users with balances greater than 10,000
