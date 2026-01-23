WITH weekly_meetings AS (
    -- Calculate total meeting hours per employee per week
    SELECT
        m.employee_id,
        DATE_ADD(m.meeting_date, INTERVAL -WEEKDAY(m.meeting_date) DAY) AS week_start,
        SUM(m.duration_hours) AS total_meeting_hours
    FROM meetings m
    GROUP BY m.employee_id, DATE_ADD(m.meeting_date, INTERVAL -WEEKDAY(m.meeting_date) DAY)
),
meeting_heavy_weeks AS (
    -- Only consider weeks with more than 20 hours in meetings
    SELECT
        employee_id,
        COUNT(*) AS meeting_heavy_weeks
    FROM weekly_meetings
    WHERE total_meeting_hours > 20
    GROUP BY employee_id
    HAVING COUNT(*) >= 2
)
SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    mhw.meeting_heavy_weeks
FROM employees e
JOIN meeting_heavy_weeks mhw
    ON e.employee_id = mhw.employee_id
ORDER BY mhw.meeting_heavy_weeks DESC, e.employee_name ASC;
