SELECT
    p.product_id,
    COALESCE(
        (
            SELECT new_price
            FROM Products
            WHERE product_id = p.product_id
              AND change_date <= '2019-08-16'
            ORDER BY change_date DESC
            LIMIT 1
        ),
        10
    ) AS price
FROM (
    -- Get all distinct products
    SELECT DISTINCT product_id
    FROM Products
) p;
