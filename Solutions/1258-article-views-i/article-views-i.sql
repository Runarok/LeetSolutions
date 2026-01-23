-- Select unique authors who have viewed their own content
SELECT DISTINCT author_id AS id   -- Get unique author IDs and rename the column as 'id'

-- From the Views table
FROM Views  

-- Only include rows where the author is the same as the viewer
WHERE author_id = viewer_id      -- This ensures we only get authors who viewed their own content

-- Sort the results in ascending order
ORDER BY id ASC;                 -- Order the list of IDs from smallest to largest

-- Explanation:
-- 1. DISTINCT removes duplicate author IDs in case they viewed their content multiple times
-- 2. author_id = viewer_id filters for self-views
-- 3. AS id renames the column for clarity
-- 4. ORDER BY id ASC makes the output ordered by author ID
