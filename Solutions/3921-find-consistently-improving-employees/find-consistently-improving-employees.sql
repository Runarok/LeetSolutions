WITH ranked_reviews AS (
    SELECT
        employee_id,
        rating,
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn
    FROM performance_reviews
),
last_three AS (
    SELECT
        employee_id,
        MAX(CASE WHEN rn = 3 THEN rating END) AS rating1,
        MAX(CASE WHEN rn = 2 THEN rating END) AS rating2,
        MAX(CASE WHEN rn = 1 THEN rating END) AS rating3
    FROM ranked_reviews
    WHERE rn <= 3
    GROUP BY employee_id
)
SELECT
    e.employee_id,
    e.name,
    (l.rating3 - l.rating1) AS improvement_score
FROM last_three l
JOIN employees e
    ON e.employee_id = l.employee_id
WHERE l.rating1 < l.rating2 AND l.rating2 < l.rating3
ORDER BY improvement_score DESC, e.name ASC;
