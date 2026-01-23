-- Select product IDs that meet specific criteria
SELECT product_id       -- Retrieve the product_id column

-- From the Products table
FROM Products

-- Filter to include only products that are low in fats and recyclable
WHERE low_fats = "Y"    -- Include only products marked as low fat
  AND recyclable = "Y"; -- Include only products marked as recyclable

-- Explanation:
-- 1. WHERE low_fats = "Y" ensures only low-fat products are selected
-- 2. AND recyclable = "Y" ensures only recyclable products are selected
-- 3. Both conditions must be true for a product to appear in the result
-- 4. The result: a list of product IDs that are both low-fat and recyclable
