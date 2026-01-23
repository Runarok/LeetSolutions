-- Select daily sales summary by date and car make
SELECT 
    date_id,                       -- The date of the sales record
    make_name,                      -- The car make or brand
    COUNT(DISTINCT lead_id) AS unique_leads,       -- Count of unique leads for that make on that date
    COUNT(DISTINCT partner_id) AS unique_partners  -- Count of unique partners for that make on that date

-- From the dailysales table
FROM dailysales  

-- Group the results by date and make to aggregate counts per day and car make
GROUP BY date_id, make_name;  

-- Explanation:
-- 1. COUNT(DISTINCT lead_id) ensures we only count each lead once per make per day
-- 2. COUNT(DISTINCT partner_id) ensures we only count each partner once per make per day
-- 3. GROUP BY date_id, make_name aggregates all sales records by day and make
-- 4. The result: a table showing the number of unique leads and partners for each car make per day
