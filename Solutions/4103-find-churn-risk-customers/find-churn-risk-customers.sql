/* ===============================================================
   CHURN RISK CUSTOMER IDENTIFICATION
   ---------------------------------------------------------------
   Definition of a Churn Risk Customer:
   A user must satisfy ALL of the following:
   1. Currently has an active subscription
      → Their most recent event is NOT 'cancel'
   2. Has performed at least one downgrade historically
   3. Current plan revenue < 50% of historical maximum revenue
   4. Has been a subscriber for at least 60 days
      → days_as_subscriber =
        (last_event_date - first_event_date)

   Output Columns:
   - user_id
   - current_plan
   - current_monthly_amount
   - max_historical_amount
   - days_as_subscriber

   Ordering:
   - days_as_subscriber DESC
   - user_id ASC
=============================================================== */


/* ---------------------------------------------------------------
   Step 1: Order events per user to identify the latest event
   ---------------------------------------------------------------
   We assign a descending row number so that:
   rn = 1 → most recent event for that user
--------------------------------------------------------------- */
WITH ordered_events AS (
    SELECT
        user_id,
        event_date,
        event_type,
        plan_name,
        monthly_amount,

        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY event_date DESC, event_id DESC
        ) AS rn
    FROM subscription_events
),

/* ---------------------------------------------------------------
   Step 2: Capture the current (latest) subscription state
   ---------------------------------------------------------------
   For each user:
   - Identify their current plan
   - Identify their current monthly amount
   - Identify their last event type
--------------------------------------------------------------- */
current_status AS (
    SELECT
        user_id,
        plan_name AS current_plan,
        monthly_amount AS current_monthly_amount,
        event_type AS last_event_type,
        event_date AS last_event_date
    FROM ordered_events
    WHERE rn = 1
),

/* ---------------------------------------------------------------
   Step 3: Aggregate historical subscription metrics per user
   ---------------------------------------------------------------
   We compute:
   - First subscription event date
   - Maximum historical monthly revenue
   - Count of downgrade events
--------------------------------------------------------------- */
historical_stats AS (
    SELECT
        user_id,

        -- First time the user subscribed or changed plans
        MIN(event_date) AS first_event_date,

        -- Highest monthly amount ever paid
        MAX(monthly_amount) AS max_historical_amount,

        -- Total number of downgrade events
        SUM(
            CASE
                WHEN event_type = 'downgrade'
                THEN 1
                ELSE 0
            END
        ) AS downgrade_count
    FROM subscription_events
    GROUP BY user_id
)

/* ---------------------------------------------------------------
   Step 4: Combine current and historical data
   ---------------------------------------------------------------
   Apply churn-risk rules:
   - Active subscription (last event not cancel)
   - At least one downgrade
   - Current revenue < 50% of max historical revenue
   - Subscriber duration >= 60 days
--------------------------------------------------------------- */
SELECT
    cs.user_id,
    cs.current_plan,
    cs.current_monthly_amount,
    hs.max_historical_amount,

    -- Days as subscriber calculation
    DATEDIFF(
        cs.last_event_date,
        hs.first_event_date
    ) AS days_as_subscriber
FROM current_status cs
JOIN historical_stats hs
    ON cs.user_id = hs.user_id
WHERE
    -- Rule 1: User must still be active
    cs.last_event_type <> 'cancel'

    -- Rule 2: At least one downgrade in history
    AND hs.downgrade_count >= 1

    -- Rule 3: Current revenue < 50% of historical max
    AND cs.current_monthly_amount < (hs.max_historical_amount * 0.50)

    -- Rule 4: Subscription duration >= 60 days
    AND DATEDIFF(
            cs.last_event_date,
            hs.first_event_date
        ) >= 60

/* ---------------------------------------------------------------
   Step 5: Final ordering
--------------------------------------------------------------- */
ORDER BY
    days_as_subscriber DESC,
    cs.user_id ASC;
