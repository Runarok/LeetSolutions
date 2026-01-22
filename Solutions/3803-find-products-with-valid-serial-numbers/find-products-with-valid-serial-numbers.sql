-- Select all products whose description contains a valid serial number
-- A valid serial number must:
-- 1. Start with 'SN' (case-sensitive)
-- 2. Be followed by exactly 4 digits
-- 3. Have a hyphen '-'
-- 4. Followed by exactly 4 digits
-- We also ensure it is a whole word so that it doesn't match something like ASN1234-5678

SELECT
    product_id,
    product_name,
    description
FROM
    products
WHERE
    -- Use REGEXP to match the pattern
    -- (? -i) makes the regex case-sensitive (not ignoring case)
    -- \\b ensures word boundaries
    description REGEXP '(?-i)\\bSN[0-9]{4}-[0-9]{4}\\b'
ORDER BY
    product_id ASC; -- Order results by product_id in ascending order
