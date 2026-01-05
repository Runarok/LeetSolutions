# Write your MySQL query statement below

SELECT name
FROM Customer
WHERE referee_id IS NULL      -- not referred by anyone
   OR referee_id != 2;        -- referred by someone with id not equal to 2
