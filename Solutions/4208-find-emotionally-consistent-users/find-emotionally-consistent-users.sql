/* ============================================================
   EMOTIONALLY CONSISTENT USER IDENTIFICATION
   ------------------------------------------------------------
   Definition:
   A user is emotionally consistent if:
   1. They have reacted to at least 5 different content items
   2. At least 60% of their reactions are of the same type

   Metrics to compute per user:
   - Total reactions
   - Dominant reaction (most frequent)
   - Reaction ratio =
       (count of dominant reaction) / (total reactions)
     → Rounded to 2 decimal places

   Ordering:
   - reaction_ratio DESC
   - user_id ASC
============================================================ */


/* ------------------------------------------------------------
   Step 1: Count reactions per (user, reaction type)
------------------------------------------------------------ */
WITH reaction_counts AS (
    SELECT
        user_id,
        reaction,
        COUNT(*) AS reaction_count
    FROM reactions
    GROUP BY user_id, reaction
),

/* ------------------------------------------------------------
   Step 2: Rank reactions per user by frequency
   - Rank 1 = dominant (most frequent) reaction
------------------------------------------------------------ */
ranked_reactions AS (
    SELECT
        user_id,
        reaction AS dominant_reaction,
        reaction_count,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY reaction_count DESC, reaction ASC
        ) AS rn
    FROM reaction_counts
),

/* ------------------------------------------------------------
   Step 3: Compute total reactions per user
------------------------------------------------------------ */
total_reactions AS (
    SELECT
        user_id,
        COUNT(*) AS total_reactions
    FROM reactions
    GROUP BY user_id
)

/* ------------------------------------------------------------
   Step 4: Combine results and apply consistency rules
------------------------------------------------------------ */
SELECT
    rr.user_id,
    rr.dominant_reaction,

    -- Reaction ratio calculation
    ROUND(
        rr.reaction_count / tr.total_reactions,
        2
    ) AS reaction_ratio
FROM ranked_reactions rr
JOIN total_reactions tr
  ON rr.user_id = tr.user_id
WHERE
    -- Keep only the dominant reaction per user
    rr.rn = 1

    -- At least 5 reactions (5 different content items by PK design)
    AND tr.total_reactions >= 5

    -- At least 60% consistency
    AND (rr.reaction_count / tr.total_reactions) >= 0.60

/* ------------------------------------------------------------
   Step 5: Final ordering
------------------------------------------------------------ */
ORDER BY
    reaction_ratio DESC,
    rr.user_id ASC;
