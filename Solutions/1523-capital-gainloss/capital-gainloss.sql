-- Select the stock name and calculate total capital gain or loss
-- The calculation adds price for 'Sell' operations and subtracts price for others
SELECT stock_name, 
       SUM(CASE WHEN operation = 'Sell' THEN price ELSE -price END) AS capital_gain_loss
FROM Stocks
-- Group results by each stock to get per-stock gain/loss
GROUP BY stock_name;

-- Alternative using IF instead of CASE for the same calculation
-- SELECT stock_name, 
--        SUM(IF(operation = 'Sell', price, -price)) AS capital_gain_loss
-- FROM Stocks
-- GROUP BY stock_name;
