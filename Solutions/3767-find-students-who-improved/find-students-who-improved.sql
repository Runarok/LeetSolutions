-- Step 1: Create a CTE (Common Table Expression) named Ranked
WITH Ranked AS (
    SELECT
        student_id,
        subject,
        -- Get the score from the **first exam date** for this student and subject
        FIRST_VALUE(score) OVER (
            PARTITION BY student_id, subject  -- separate by student and subject
            ORDER BY exam_date                 -- order chronologically
        ) AS first_score,

        -- Get the score from the **latest exam date** for this student and subject
        FIRST_VALUE(score) OVER (
            PARTITION BY student_id, subject  -- same partition
            ORDER BY exam_date DESC            -- order reverse chronologically
        ) AS latest_score

    FROM Scores
)

-- Step 2: Select the students who have improved
SELECT DISTINCT *
FROM Ranked
-- Only include rows where the latest score is higher than the first score
WHERE first_score < latest_score
-- Step 3: Order results by student and subject
ORDER BY student_id, subject;
