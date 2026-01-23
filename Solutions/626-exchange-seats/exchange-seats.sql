-- Select a modified seat ID and the student name
SELECT 
    CASE 
        -- If the seat ID is odd AND the next seat exists, swap with the next seat
        WHEN id % 2 = 1 AND id + 1 IN (SELECT id FROM Seat) THEN id + 1  

        -- If the seat ID is even, swap with the previous seat
        WHEN id % 2 = 0 THEN id - 1  

        -- Otherwise (no swap possible), keep the same ID
        ELSE id  
    END AS id,  
    student      -- Include the student name

-- From the Seat table
FROM Seat  

-- Order the results by the new seat ID
ORDER BY id;  

-- Explanation:
-- 1. id % 2 = 1 checks if the seat ID is odd
-- 2. id + 1 IN (SELECT id FROM Seat) ensures that the next seat exists before swapping
-- 3. id % 2 = 0 handles even IDs by swapping with the previous seat
-- 4. ELSE id keeps IDs unchanged if they cannot be swapped
-- 5. The CASE statement effectively simulates swapping adjacent seats
-- 6. ORDER BY id sorts the final seating arrangement by the new IDs
