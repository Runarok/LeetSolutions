/* ============================================================
   POLARIZED BOOK OPINIONS ANALYSIS
   ------------------------------------------------------------
   Goal:
   Identify books that receive BOTH very high and very low
   ratings from readers, indicating polarized opinions.

   Business Rules:
   1. At least one rating >= 4 (high rating)
   2. At least one rating <= 2 (low rating)
   3. Minimum of 5 reading sessions per book
   4. Polarization score >= 0.60
   5. Polarization score =
        (# of extreme ratings) / (total sessions)
      where extreme ratings are:
        rating <= 2 OR rating >= 4
   6. Rating spread = max_rating - min_rating

   Output Ordering:
   - polarization_score DESC
   - title DESC
============================================================ */


/* ------------------------------------------------------------
   Step 1: Aggregate reading session statistics per book
   - Count total sessions
   - Find highest and lowest ratings
   - Count extreme ratings
   - Detect presence of both high and low ratings
------------------------------------------------------------ */
WITH rating_stats AS (
    SELECT
        rs.book_id,

        -- Total number of reading sessions
        COUNT(*) AS total_sessions,

        -- Highest and lowest ratings for spread calculation
        MAX(rs.session_rating) AS max_rating,
        MIN(rs.session_rating) AS min_rating,

        -- Count of extreme ratings (<= 2 OR >= 4)
        SUM(
            CASE
                WHEN rs.session_rating <= 2
                  OR rs.session_rating >= 4
                THEN 1
                ELSE 0
            END
        ) AS extreme_ratings,

        -- Count of high ratings (>= 4)
        SUM(
            CASE
                WHEN rs.session_rating >= 4
                THEN 1
                ELSE 0
            END
        ) AS high_ratings,

        -- Count of low ratings (<= 2)
        SUM(
            CASE
                WHEN rs.session_rating <= 2
                THEN 1
                ELSE 0
            END
        ) AS low_ratings
    FROM reading_sessions rs
    GROUP BY rs.book_id
),

/* ------------------------------------------------------------
   Step 2: Apply polarization rules and calculate metrics
   - Enforce minimum session count
   - Require at least one high and one low rating
   - Calculate rating spread
   - Calculate polarization score
------------------------------------------------------------ */
polarized_books AS (
    SELECT
        book_id,

        -- Rating spread calculation
        (max_rating - min_rating) AS rating_spread,

        -- Polarization score calculation
        ROUND(
            extreme_ratings / total_sessions,
            2
        ) AS polarization_score
    FROM rating_stats
    WHERE total_sessions >= 5             -- Minimum sessions
      AND high_ratings >= 1               -- At least one high rating
      AND low_ratings >= 1                -- At least one low rating
      AND (extreme_ratings / total_sessions) >= 0.6
)

/* ------------------------------------------------------------
   Step 3: Join with books table to return final result
   - Include book details
   - Apply required ordering
------------------------------------------------------------ */
SELECT
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,
    pb.rating_spread,
    pb.polarization_score
FROM polarized_books pb
JOIN books b
  ON b.book_id = pb.book_id
ORDER BY
    pb.polarization_score DESC,
    b.title DESC;
