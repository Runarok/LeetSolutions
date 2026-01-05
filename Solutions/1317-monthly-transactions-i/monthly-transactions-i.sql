# Write your MySQL query statement below

SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,  -- extract YYYY-MM
    country,
    COUNT(*) AS trans_count,                    -- total transactions
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,  -- approved transactions
    SUM(amount) AS trans_total_amount,         -- total amount
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount  -- approved amount
FROM Transactions
GROUP BY month, country;
