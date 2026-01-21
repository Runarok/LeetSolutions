-- -------------------------------------------------------
-- Step 0: Context
-- Goal: Find the most frequent "course transitions" between two courses
-- for users who have completed more than 4 courses and have an average
-- course rating >= 4.
-- -------------------------------------------------------

-- Step 1: Identify top users who meet criteria
WITH find_top_user AS (
    SELECT user_id
    FROM course_completions 
    GROUP BY user_id
    HAVING 
        COUNT(DISTINCT course_id) > 4  -- User must complete more than 4 unique courses
        AND AVG(course_rating) >= 4    -- User's average rating >= 4
)
-- Step 2: Main query to find course transitions
SELECT first_course, second_course, transition_count
FROM (
    -- Step 2a: For each course completion A, find the next course B for the same user
    SELECT 
        A.course_name AS first_course,   -- Current course
        sub.course_name AS second_course, -- Next course completed
        COUNT(1) AS transition_count      -- Count how many times this transition occurs
    FROM course_completions A 
    -- Step 2b: Use LATERAL join to find the *next* course for same user
    LEFT JOIN LATERAL (
        SELECT course_name
        FROM course_completions B 
        WHERE 
            A.user_id = B.user_id         -- Same user
            AND A.completion_date < B.completion_date  -- Must be after current course
        LIMIT 1                           -- Take only the very next course
    ) sub ON 1 = 1                        -- LATERAL join always returns a row if exists
    -- Step 2c: Filter only top users
    WHERE 
        A.user_id IN (SELECT user_id FROM find_top_user)
        AND sub.course_name IS NOT NULL   -- Only consider transitions that exist
    -- Step 2d: Group by course pairs to count transitions
    GROUP BY 
        A.course_name, 
        sub.course_name
) AS transitions
-- Step 3: Order results by most frequent transitions, then alphabetically
ORDER BY 
    transition_count DESC,              -- Most common transitions first
    LOWER(first_course),                -- Alphabetical tie-breaker (case-insensitive)
    LOWER(second_course);
