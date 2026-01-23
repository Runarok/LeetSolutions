SELECT
    query_name,
    -- Calculate the average of rating / position per query
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,
    
    -- Calculate the percentage of queries with rating < 3
    ROUND(
        SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
