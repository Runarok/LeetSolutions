/* ============================================================
   ZOMBIE SESSION DETECTION
   ------------------------------------------------------------
   Definition of a Zombie Session:
   A session must satisfy ALL of the following:
   1. Session duration > 30 minutes
   2. At least 5 scroll events
   3. Click-to-scroll ratio < 0.20
   4. No purchase events in the session

   Click-to-scroll ratio =
       (# of click events) / (# of scroll events)

   Output:
   - session_id
   - user_id
   - session_duration_minutes
   - scroll_count

   Ordering:
   - scroll_count DESC
   - session_id ASC
============================================================ */


/* ------------------------------------------------------------
   Step 1: Aggregate event-level data at the session level
   ------------------------------------------------------------
   For each (session_id, user_id), compute:
   - Session start time
   - Session end time
   - Total scroll events
   - Total click events
   - Total purchase events
------------------------------------------------------------ */
WITH session_stats AS (
    SELECT
        session_id,
        user_id,

        -- Session start and end timestamps
        MIN(event_timestamp) AS session_start,
        MAX(event_timestamp) AS session_end,

        -- Count scroll events
        SUM(
            CASE
                WHEN event_type = 'scroll'
                THEN 1
                ELSE 0
            END
        ) AS scroll_count,

        -- Count click events
        SUM(
            CASE
                WHEN event_type = 'click'
                THEN 1
                ELSE 0
            END
        ) AS click_count,

        -- Count purchase events
        SUM(
            CASE
                WHEN event_type = 'purchase'
                THEN 1
                ELSE 0
            END
        ) AS purchase_count
    FROM app_events
    GROUP BY
        session_id,
        user_id
)

/* ------------------------------------------------------------
   Step 2: Apply zombie session criteria
   ------------------------------------------------------------
   - Duration > 30 minutes
   - At least 5 scrolls
   - Click-to-scroll ratio < 0.20
   - No purchases
------------------------------------------------------------ */
SELECT
    session_id,
    user_id,

    -- Session duration in minutes
    TIMESTAMPDIFF(
        MINUTE,
        session_start,
        session_end
    ) AS session_duration_minutes,

    scroll_count
FROM session_stats
WHERE
    -- Rule 1: Session duration must exceed 30 minutes
    TIMESTAMPDIFF(
        MINUTE,
        session_start,
        session_end
    ) > 30

    -- Rule 2: Minimum scroll activity
    AND scroll_count >= 5

    -- Rule 3: Click-to-scroll ratio < 0.20
    AND (click_count / scroll_count) < 0.20

    -- Rule 4: No purchases allowed
    AND purchase_count = 0

/* ------------------------------------------------------------
   Step 3: Order final result
------------------------------------------------------------ */
ORDER BY
    scroll_count DESC,
    session_id ASC;
