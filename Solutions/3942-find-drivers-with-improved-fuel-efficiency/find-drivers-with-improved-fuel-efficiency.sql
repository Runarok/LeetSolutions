-- CTE to calculate average fuel efficiency per driver for first and second half of the year
WITH efficiency AS (
    SELECT 
        driver_id,
        -- Average efficiency (distance per fuel) for months 1 to 6
        AVG(
            CASE 
                WHEN MONTH(trip_date) BETWEEN 1 AND 6 THEN distance_km / fuel_consumed 
            END
        ) AS first_half_avg,
        
        -- Average efficiency for months 7 to 12
        AVG(
            CASE 
                WHEN MONTH(trip_date) BETWEEN 7 AND 12 THEN distance_km / fuel_consumed 
            END
        ) AS second_half_avg
    FROM trips
    GROUP BY driver_id
)

-- Main query to fetch driver info along with efficiency improvement
SELECT 
    d.driver_id, 
    d.driver_name,
    ROUND(e.first_half_avg, 2) AS first_half_avg,        -- Rounded for readability
    ROUND(e.second_half_avg, 2) AS second_half_avg,      -- Rounded for readability
    ROUND(e.second_half_avg - e.first_half_avg, 2) AS efficiency_improvement  -- Difference rounded
FROM drivers d
LEFT JOIN efficiency e 
    ON e.driver_id = d.driver_id
-- Ensure we only consider drivers with valid data for both halves
WHERE e.first_half_avg IS NOT NULL
  AND e.second_half_avg IS NOT NULL
-- Only consider drivers whose efficiency improved
  AND (e.second_half_avg - e.first_half_avg) > 0
-- Sort by most improved efficiency first, then by name as tie-breaker
ORDER BY efficiency_improvement DESC, d.driver_name;
