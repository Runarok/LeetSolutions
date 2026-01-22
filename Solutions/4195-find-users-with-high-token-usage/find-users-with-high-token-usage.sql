/* ============================================================
   AI PROMPT USAGE PATTERN ANALYSIS
   ------------------------------------------------------------
   Requirements:
   1. For each user:
      - Count total number of prompts submitted
      - Calculate average tokens per prompt (rounded to 2 decimals)
   2. Include only users who:
      - Have submitted at least 3 prompts
      - Have at least one prompt with tokens > their own average
   3. Order results by:
      - avg_tokens DESC
      - user_id ASC
============================================================ */


/* ------------------------------------------------------------
   Step 1: Aggregate prompt statistics per user
   ------------------------------------------------------------
   We calculate:
   - Total prompt count
   - Average tokens per prompt
------------------------------------------------------------ */
WITH user_prompt_stats AS (
    SELECT
        user_id,

        -- Total number of prompts submitted by the user
        COUNT(*) AS prompt_count,

        -- Average tokens per prompt (rounded to 2 decimals)
        ROUND(
            AVG(tokens),
            2
        ) AS avg_tokens
    FROM prompts
    GROUP BY user_id
),

/* ------------------------------------------------------------
   Step 2: Identify users who have at least one prompt
           exceeding their own average token usage
------------------------------------------------------------ */
above_average_users AS (
    SELECT DISTINCT
        p.user_id
    FROM prompts p
    JOIN user_prompt_stats ups
      ON p.user_id = ups.user_id
    WHERE p.tokens > ups.avg_tokens
)

/* ------------------------------------------------------------
   Step 3: Apply final filters and return result
   ------------------------------------------------------------
   Conditions enforced:
   - Minimum 3 prompts
   - At least one prompt above user’s average
------------------------------------------------------------ */
SELECT
    ups.user_id,
    ups.prompt_count,
    ups.avg_tokens
FROM user_prompt_stats ups
JOIN above_average_users aau
  ON ups.user_id = aau.user_id
WHERE ups.prompt_count >= 3

/* ------------------------------------------------------------
   Step 4: Final ordering
------------------------------------------------------------ */
ORDER BY
    ups.avg_tokens DESC,
    ups.user_id ASC;
