-- Calculate the average processing time for each machine
SELECT
    machine_id, 
    ROUND(AVG(end_time - start_time), 3) AS processing_time  -- Average time per process, rounded to 3 decimals
FROM (
    -- Get start and end timestamps for each process on each machine
    SELECT
        machine_id,
        process_id,
        MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,  -- Start timestamp
        MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time       -- End timestamp
    FROM Activity
    GROUP BY machine_id, process_id
) t
-- Compute average processing time per machine
GROUP BY machine_id;
