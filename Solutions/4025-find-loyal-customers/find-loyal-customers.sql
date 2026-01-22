/* ============================================================
   LOYAL CUSTOMER IDENTIFICATION
   ------------------------------------------------------------
   Definition of a Loyal Customer:
   A customer must satisfy ALL of the following:
   1. At least 3 purchase transactions
   2. Active for at least 30 days
      (difference between first and last transaction dates)
   3. Refund rate < 20%
      Refund rate = (# of refund transactions) /
                    (total transactions)

   Output:
   - Only customer_id
   - Ordered by customer_id ASC
============================================================ */


/* ------------------------------------------------------------
   Step 1: Aggregate transaction-level metrics per customer
   ------------------------------------------------------------
   We calculate:
   - Total transactions
   - Number of purchase transactions
   - Number of refund transactions
   - First transaction date
   - Last transaction date
------------------------------------------------------------ */
WITH customer_stats AS (
    SELECT
        customer_id,

        -- Total number of transactions (purchase + refund)
        COUNT(*) AS total_transactions,

        -- Count of purchase transactions
        SUM(
            CASE
                WHEN transaction_type = 'purchase'
                THEN 1
                ELSE 0
            END
        ) AS purchase_count,

        -- Count of refund transactions
        SUM(
            CASE
                WHEN transaction_type = 'refund'
                THEN 1
                ELSE 0
            END
        ) AS refund_count,

        -- Earliest transaction date (start of activity)
        MIN(transaction_date) AS first_transaction_date,

        -- Latest transaction date (end of activity)
        MAX(transaction_date) AS last_transaction_date
    FROM customer_transactions
    GROUP BY customer_id
)

/* ------------------------------------------------------------
   Step 2: Apply loyalty rules
   ------------------------------------------------------------
   - Minimum 3 purchases
   - Active period >= 30 days
   - Refund rate < 20%
------------------------------------------------------------ */
SELECT
    customer_id
FROM customer_stats
WHERE
    -- Rule 1: At least 3 purchase transactions
    purchase_count >= 3

    -- Rule 2: Active for at least 30 days
    AND DATEDIFF(last_transaction_date, first_transaction_date) >= 30

    -- Rule 3: Refund rate less than 20%
    AND (refund_count / total_transactions) < 0.20

/* ------------------------------------------------------------
   Step 3: Order final result
------------------------------------------------------------ */
ORDER BY customer_id ASC;
