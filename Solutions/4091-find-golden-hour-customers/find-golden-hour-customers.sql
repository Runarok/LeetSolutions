/* ============================================================
   GOLDEN HOUR CUSTOMER IDENTIFICATION
   ------------------------------------------------------------
   Definition of a Golden Hour Customer:
   A customer must satisfy ALL of the following:
   1. Made at least 3 total orders
   2. At least 60% of orders placed during peak hours:
        - Lunch peak: 11:00–14:00
        - Dinner peak: 18:00–21:00
   3. Rated at least 50% of their orders
   4. Average rating (only rated orders) >= 4.0
      - Rounded to 2 decimal places

   Output Columns:
   - customer_id
   - total_orders
   - peak_hour_percentage
   - average_rating

   Ordering:
   - average_rating DESC
   - customer_id DESC
============================================================ */


/* ------------------------------------------------------------
   Step 1: Aggregate order-level metrics per customer
   ------------------------------------------------------------
   We calculate:
   - Total orders
   - Peak hour orders
   - Rated orders count
   - Average rating (rated orders only)
------------------------------------------------------------ */
WITH customer_order_stats AS (
    SELECT
        customer_id,

        -- Total number of orders
        COUNT(*) AS total_orders,

        -- Count of orders placed during peak hours
        SUM(
            CASE
                WHEN (
                    -- Lunch peak: 11:00 to 14:00
                    TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00'
                    OR
                    -- Dinner peak: 18:00 to 21:00
                    TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00'
                )
                THEN 1
                ELSE 0
            END
        ) AS peak_hour_orders,

        -- Count of orders that have ratings
        COUNT(order_rating) AS rated_orders,

        -- Average rating considering only rated orders
        ROUND(
            AVG(order_rating),
            2
        ) AS average_rating
    FROM restaurant_orders
    GROUP BY customer_id
)

/* ------------------------------------------------------------
   Step 2: Apply Golden Hour eligibility rules
   ------------------------------------------------------------
   - Minimum order count
   - Peak hour percentage >= 60%
   - Rated orders >= 50%
   - Average rating >= 4.0
------------------------------------------------------------ */
SELECT
    customer_id,
    total_orders,

    -- Peak hour percentage calculation
    ROUND(
        (peak_hour_orders / total_orders) * 100,
        0
    ) AS peak_hour_percentage,

    average_rating
FROM customer_order_stats
WHERE
    -- Rule 1: At least 3 total orders
    total_orders >= 3

    -- Rule 2: At least 60% of orders during peak hours
    AND (peak_hour_orders / total_orders) >= 0.60

    -- Rule 3: At least 50% of orders are rated
    AND (rated_orders / total_orders) >= 0.50

    -- Rule 4: Average rating must be at least 4.0
    AND average_rating >= 4.0

/* ------------------------------------------------------------
   Step 3: Order final result
------------------------------------------------------------ */
ORDER BY
    average_rating DESC,
    customer_id DESC;
