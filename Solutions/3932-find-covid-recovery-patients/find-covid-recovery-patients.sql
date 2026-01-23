SELECT
    p.patient_id,
    p.patient_name,
    p.age,
    -- Calculate recovery time as days between first positive
    -- and first negative test AFTER that positive
    DATEDIFF(n.first_negative_date, fp.first_positive_date) AS recovery_time
FROM patients p
JOIN (
    -- Get each patient's FIRST positive test date
    SELECT
        patient_id,
        MIN(test_date) AS first_positive_date
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
) fp
    ON p.patient_id = fp.patient_id
JOIN (
    -- Get the FIRST negative test date that occurs
    -- AFTER the patient's first positive test
    SELECT
        ct.patient_id,
        MIN(ct.test_date) AS first_negative_date
    FROM covid_tests ct
    JOIN (
        -- Reuse first positive date per patient
        SELECT
            patient_id,
            MIN(test_date) AS first_positive_date
        FROM covid_tests
        WHERE result = 'Positive'
        GROUP BY patient_id
    ) fp2
        ON ct.patient_id = fp2.patient_id
    -- Only consider negative tests
    WHERE ct.result = 'Negative'
      -- Ensure the negative test is AFTER the first positive
      AND ct.test_date > fp2.first_positive_date
    GROUP BY ct.patient_id
) n
    ON p.patient_id = n.patient_id
-- Order by recovery time, then by patient name
ORDER BY recovery_time ASC, p.patient_name ASC;
