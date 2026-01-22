/* -------------------------------------------------------
   Step 1: Order study sessions per student by date
   - Assign a row number to preserve sequence
   - Capture the previous session date to detect gaps
------------------------------------------------------- */
WITH ordered_sessions AS (
    SELECT
        s.student_id,
        s.subject,
        s.session_date,
        s.hours_studied,
        ROW_NUMBER() OVER (
            PARTITION BY s.student_id
            ORDER BY s.session_date
        ) AS rn,
        LAG(s.session_date) OVER (
            PARTITION BY s.student_id
            ORDER BY s.session_date
        ) AS prev_date
    FROM study_sessions s
),

/* -------------------------------------------------------
   Step 2: Filter out sessions that break the continuity
   - Only keep sessions where the gap from the previous
     session is 2 days or less
------------------------------------------------------- */
valid_sessions AS (
    SELECT *
    FROM ordered_sessions
    WHERE prev_date IS NULL
       OR DATEDIFF(session_date, prev_date) <= 2
),

/* -------------------------------------------------------
   Step 3: Compute per-student aggregates
   - Total number of valid sessions
   - Number of distinct subjects (cycle length)
   - Total study hours across valid sessions
------------------------------------------------------- */
student_stats AS (
    SELECT
        student_id,
        COUNT(*) AS total_sessions,
        COUNT(DISTINCT subject) AS cycle_length,
        SUM(hours_studied) AS total_study_hours
    FROM valid_sessions
    GROUP BY student_id
),

/* -------------------------------------------------------
   Step 4: Keep only students who satisfy
   Study Spiral Pattern requirements
   - At least 3 different subjects
   - At least 2 full cycles (sessions >= 2 * cycle length)
------------------------------------------------------- */
spiral_students AS (
    SELECT *
    FROM student_stats
    WHERE cycle_length >= 3
      AND total_sessions >= cycle_length * 2
)

/* -------------------------------------------------------
   Step 5: Join with students table and return result
   - Ordered by cycle length (DESC)
   - Then by total study hours (DESC)
------------------------------------------------------- */
SELECT
    st.student_id,
    st.student_name,
    st.major,
    sp.cycle_length,
    sp.total_study_hours
FROM spiral_students sp
JOIN students st
  ON st.student_id = sp.student_id
ORDER BY
    sp.cycle_length DESC,
    sp.total_study_hours DESC;
