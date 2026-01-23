-- Select product prices from multiple stores and combine them into one result
SELECT product_id,               -- Get the product ID
       'store1' AS store,        -- Label the store as 'store1'
       store1 AS price           -- Get the price from the store1 column
FROM products
WHERE store1 IS NOT NULL        -- Only include products that have a price in store1

-- Combine with store2 prices
UNION
SELECT product_id,               -- Get the product ID
       'store2' AS store,        -- Label the store as 'store2'
       store2 AS price           -- Get the price from the store2 column
FROM products
WHERE store2 IS NOT NULL        -- Only include products that have a price in store2

-- Combine with store3 prices
UNION
SELECT product_id,               -- Get the product ID
       'store3' AS store,        -- Label the store as 'store3'
       store3 AS price           -- Get the price from the store3 column
FROM products
WHERE store3 IS NOT NULL;       -- Only include products that have a price in store3

-- Explanation:
-- 1. Each SELECT retrieves product_id and its price from one store column
-- 2. 'storeX' AS store adds a label to indicate which store the price is from
-- 3. WHERE storeX IS NOT NULL filters out products that are not sold in that store
-- 4. UNION combines all three results into a single table
-- 5. Result: a vertical list of products, their store, and price for all available stores
