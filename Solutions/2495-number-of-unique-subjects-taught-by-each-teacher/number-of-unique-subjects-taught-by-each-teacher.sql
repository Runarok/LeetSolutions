-- Select each teacher and count the number of distinct subjects they teach
SELECT teacher_id,                       -- Get the teacher's ID
       COUNT(DISTINCT subject_id) AS cnt -- Count unique subjects taught by this teacher

-- From the Teacher table
FROM Teacher

-- Group the results by teacher to aggregate subject counts per teacher
GROUP BY teacher_id;

-- Explanation:
-- 1. COUNT(DISTINCT subject_id) ensures each subject is only counted once per teacher
-- 2. GROUP BY teacher_id aggregates all records for the same teacher
-- 3. The result: each teacher_id with the number of distinct subjects they teach
