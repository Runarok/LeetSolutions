/* =========================================================
   INVENTORY IMBALANCE DETECTION
   ---------------------------------------------------------
   Goal:
   Find stores where the most expensive product has
   LOWER stock than the cheapest product.

   Conditions:
   - Identify most expensive product per store
   - Identify cheapest product per store
   - Store must have at least 3 different products
   - Imbalance exists if:
         expensive_quantity < cheapest_quantity
   - Imbalance ratio:
         cheapest_quantity / expensive_quantity
     (rounded to 2 decimal places)
   - Order results by:
         imbalance_ratio DESC,
         store_name ASC
========================================================= */

WITH ranked_inventory AS (
    /* -----------------------------------------------------
       Step 1: Rank products within each store
       - Highest price → rank 1 (most expensive)
       - Lowest price  → rank 1 (cheapest)
       ----------------------------------------------------- */
    SELECT
        i.store_id,
        i.product_name,
        i.quantity,
        i.price,

        -- Rank products by price descending (most expensive first)
        ROW_NUMBER() OVER (
            PARTITION BY i.store_id
            ORDER BY i.price DESC
        ) AS expensive_rank,

        -- Rank products by price ascending (cheapest first)
        ROW_NUMBER() OVER (
            PARTITION BY i.store_id
            ORDER BY i.price ASC
        ) AS cheap_rank
    FROM inventory i
),

store_product_counts AS (
    /* -----------------------------------------------------
       Step 2: Count number of distinct products per store
       - Only stores with at least 3 products qualify
       ----------------------------------------------------- */
    SELECT
        store_id,
        COUNT(DISTINCT product_name) AS product_count
    FROM inventory
    GROUP BY store_id
),

expensive_products AS (
    /* -----------------------------------------------------
       Step 3: Extract the most expensive product per store
       ----------------------------------------------------- */
    SELECT
        store_id,
        product_name AS most_exp_product,
        quantity AS expensive_quantity
    FROM ranked_inventory
    WHERE expensive_rank = 1
),

cheapest_products AS (
    /* -----------------------------------------------------
       Step 4: Extract the cheapest product per store
       ----------------------------------------------------- */
    SELECT
        store_id,
        product_name AS cheapest_product,
        quantity AS cheapest_quantity
    FROM ranked_inventory
    WHERE cheap_rank = 1
)

SELECT
    s.store_id,
    s.store_name,
    s.location,

    -- Product names
    e.most_exp_product,
    c.cheapest_product,

    -- Imbalance ratio calculation
    ROUND(
        c.cheapest_quantity / e.expensive_quantity,
        2
    ) AS imbalance_ratio

FROM stores s

/* ---------------------------------------------------------
   Join most expensive and cheapest products
--------------------------------------------------------- */
JOIN expensive_products e
    ON s.store_id = e.store_id
JOIN cheapest_products c
    ON s.store_id = c.store_id

/* ---------------------------------------------------------
   Ensure store has at least 3 products
--------------------------------------------------------- */
JOIN store_product_counts spc
    ON s.store_id = spc.store_id
   AND spc.product_count >= 3

/* ---------------------------------------------------------
   Inventory imbalance condition:
   expensive stock < cheapest stock
--------------------------------------------------------- */
WHERE e.expensive_quantity < c.cheapest_quantity

/* ---------------------------------------------------------
   Final ordering
--------------------------------------------------------- */
ORDER BY
    imbalance_ratio DESC,
    s.store_name ASC;
