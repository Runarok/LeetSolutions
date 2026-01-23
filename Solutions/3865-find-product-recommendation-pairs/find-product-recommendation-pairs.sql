-- Step 1: Find pairs of products purchased by the same customer
SELECT 
    p1.product_id AS product1_id,         -- ID of the first product in the pair
    p2.product_id AS product2_id,         -- ID of the second product in the pair
    i1.category AS product1_category,     -- Category of the first product
    i2.category AS product2_category,     -- Category of the second product
    COUNT(p1.user_id) AS customer_count   -- Number of customers who bought both products
FROM ProductPurchases p1
INNER JOIN ProductPurchases p2 
    ON p1.user_id = p2.user_id            -- Match purchases by the same user
    AND p1.product_id < p2.product_id     -- Avoid duplicate pairs (A,B) and (B,A)
LEFT JOIN ProductInfo i1 
    ON p1.product_id = i1.product_id      -- Get category info for product 1
LEFT JOIN ProductInfo i2 
    ON p2.product_id = i2.product_id      -- Get category info for product 2
GROUP BY product1_id, product2_id        -- Aggregate by unique product pairs
HAVING customer_count > 2                -- Only keep pairs bought by more than 2 customers
ORDER BY customer_count DESC,            -- Sort by popularity (most shared customers first)
         product1_id, 
         product2_id;
