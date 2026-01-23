-- Retrieve countries with either a large area or a large population
SELECT 
    name,            -- Country name
    population,      -- Population of the country
    area             -- Area of the country
FROM World
-- Filter countries with area at least 3,000,000 OR population at least 25,000,000
WHERE area >= 3000000 OR population >= 25000000;
