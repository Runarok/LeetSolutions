WITH RECURSIVE words AS (
    -- Step 1: Split content_text into words
    SELECT
        content_id,
        content_text AS original_text,
        TRIM(SUBSTRING_INDEX(content_text, ' ', 1)) AS word,
        TRIM(SUBSTRING(content_text, LENGTH(SUBSTRING_INDEX(content_text, ' ', 1)) + 2)) AS rest,
        1 AS word_index
    FROM user_content

    UNION ALL

    -- Step 2: Recursively get remaining words
    SELECT
        content_id,
        original_text,
        TRIM(SUBSTRING_INDEX(rest, ' ', 1)) AS word,
        TRIM(SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ' ', 1)) + 2)) AS rest,
        word_index + 1
    FROM words
    WHERE rest <> ''
),

capitalized AS (
    -- Step 3: Capitalize each word and handle hyphens
    SELECT
        content_id,
        original_text,
        word_index,
        -- Capitalize each part of a hyphenated word
        CONCAT_WS('-', 
            CONCAT(UPPER(SUBSTRING(SUBSTRING_INDEX(word,'-',1),1,1)),
                   LOWER(SUBSTRING(SUBSTRING_INDEX(word,'-',1),2))),
            IF(INSTR(word,'-')>0,
               CONCAT(UPPER(SUBSTRING(SUBSTRING_INDEX(word,'-',-1),1,1)),
                      LOWER(SUBSTRING(SUBSTRING_INDEX(word,'-',-1),2))),
               NULL)
        ) AS converted_word
    FROM words
)

-- Step 4: Recombine words in original order
SELECT
    content_id,
    original_text,
    GROUP_CONCAT(converted_word ORDER BY word_index SEPARATOR ' ') AS converted_text
FROM capitalized
GROUP BY content_id, original_text
ORDER BY content_id;
