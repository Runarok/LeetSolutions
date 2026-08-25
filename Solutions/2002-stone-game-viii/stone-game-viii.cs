public class Solution
{
    public int StoneGameVIII(int[] stones)
    {
        // Number of stones in the array.
        int n = stones.Length;

        /*
         * pre[i] stores the prefix sum:
         *
         * pre[i] = stones[0] + stones[1] + ... + stones[i]
         *
         * For example:
         *
         * stones = [-1, 2, -3, 4, -5]
         *
         * pre = [-1, 1, -2, 2, -3]
         *
         * This is useful because whenever a player removes
         * the first i + 1 stones, their score is simply pre[i].
         */
        int[] pre = new int[n];

        // The prefix sum containing only the first stone.
        pre[0] = stones[0];

        // Build all remaining prefix sums.
        for (int i = 1; i < n; i++)
        {
            pre[i] = pre[i - 1] + stones[i];
        }

        /*
         * f[i] represents the maximum score difference
         * (current player's score - other player's score)
         * when the game is in a state where the relevant
         * prefix ends at index i.
         *
         * We only need f[1] in the end because the first move
         * must remove at least 2 stones.
         */
        int[] f = new int[n];

        /*
         * Base case:
         *
         * If we reach i = n - 1, the player can take all
         * remaining stones represented by the entire prefix.
         *
         * Therefore the score difference is simply the total sum.
         *
         * Example:
         *
         * stones = [-1, 2, -3, 4, -5]
         * pre[4] = -3
         *
         * So:
         * f[4] = -3
         */
        f[n - 1] = pre[n - 1];

        /*
         * Work backwards from n - 2 to 1.
         *
         * At position i, the current player has two possibilities
         * represented by the recurrence:
         *
         *     f[i] = max(
         *         f[i + 1],
         *         pre[i] - f[i + 1]
         *     )
         *
         * ---------------------------------------------------------
         *
         * First possibility:
         *
         *     f[i + 1]
         *
         * This means we keep the best result we can obtain
         * from the next state.
         *
         * ---------------------------------------------------------
         *
         * Second possibility:
         *
         *     pre[i] - f[i + 1]
         *
         * If the current player chooses to combine the first
         * i + 1 stones, they immediately score pre[i].
         *
         * After that move, it is the opponent's turn.
         *
         * The opponent can obtain f[i + 1] as their advantage.
         *
         * Since our goal is:
         *
         *     our score - opponent's score
         *
         * the resulting difference is:
         *
         *     pre[i] - f[i + 1]
         *
         * We take the maximum because the current player
         * always chooses the better option.
         */
        for (int i = n - 2; i >= 1; i--)
        {
            f[i] = Math.Max(
                f[i + 1],
                pre[i] - f[i + 1]
            );
        }

        /*
         * The first player is Alice.
         *
         * Alice must remove at least 2 stones on her first move,
         * so the game starts from the state represented by f[1].
         *
         * f[1] therefore represents:
         *
         *     Alice's score - Bob's score
         *
         * when both players play optimally.
         */
        return f[1];
    }
}

