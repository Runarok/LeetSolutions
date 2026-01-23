-- Calculate daily sums of odd and even transaction amounts
SELECT
    transaction_date,  -- Date of the transaction
    IFNULL(SUM(CASE WHEN amount % 2 != 0 THEN amount END), 0) AS odd_sum,   -- Sum of odd amounts, default to 0 if none
    IFNULL(SUM(CASE WHEN amount % 2 = 0 THEN amount END), 0) AS even_sum   -- Sum of even amounts, default to 0 if none
FROM transactions
-- Group transactions by date to compute daily sums
GROUP BY transaction_date
-- Order results by date
ORDER BY transaction_date;
