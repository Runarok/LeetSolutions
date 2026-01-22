WITH UserCategories AS (
    -- Get unique categories purchased by each user
    SELECT DISTINCT 
        pp.user_id,
        pi.category
    FROM ProductPurchases pp
    JOIN ProductInfo pi
        ON pp.product_id = pi.product_id
),
UserCategoryPairs AS (
    -- Generate all category pairs per user where category1 < category2
    -- This avoids duplicate/reverse pairs like (Books, Electronics) and (Electronics, Books)
    SELECT 
        uc1.user_id,
        uc1.category AS category1,
        uc2.category AS category2
    FROM UserCategories uc1
    JOIN UserCategories uc2
        ON uc1.user_id = uc2.user_id
        AND uc1.category < uc2.category
),
CategoryPairCounts AS (
    -- Count unique users for each category pair
    SELECT
        category1,
        category2,
        COUNT(DISTINCT user_id) AS customer_count
    FROM UserCategoryPairs
    GROUP BY category1, category2
)
-- Filter pairs with at least 3 users and order results as required
SELECT
    category1,
    category2,
    customer_count
FROM CategoryPairCounts
WHERE customer_count >= 3
ORDER BY customer_count DESC, category1 ASC, category2 ASC;
