class Solution {
    public int stoneGameII(int[] piles) {

        int n = piles.length;

        /*
         * suffix[i] = total number of stones from pile i
         *              until the end.
         *
         * Example:
         * piles  = [2, 7, 9, 4, 4]
         *
         * suffix = [26, 24, 17, 8, 4, 0]
         *
         * This lets us quickly calculate how many stones
         * are available from a particular index.
         */
        int[] suffix = new int[n + 1];

        for (int i = n - 1; i >= 0; i--) {
            suffix[i] = suffix[i + 1] + piles[i];
        }

        /*
         * dp[i][M] represents:
         *
         * The maximum number of stones the CURRENT player
         * can get when:
         *
         *   - we are currently at pile i
         *   - the current value of M is M
         *
         * Since n <= 100, M can be at most n.
         */
        int[][] dp = new int[n + 1][n + 1];

        /*
         * We calculate the answer from the end of the array
         * towards the beginning.
         *
         * Why?
         *
         * dp[i][M] depends on dp[i + X][newM],
         * where i + X is further to the right.
         *
         * Therefore, those states should already be calculated.
         */
        for (int i = n - 1; i >= 0; i--) {

            /*
             * M can range from 1 to n.
             */
            for (int M = 1; M <= n; M++) {

                /*
                 * If we can take all remaining piles,
                 * we simply take everything.
                 *
                 * We can take at most 2 * M piles.
                 */
                if (i + 2 * M >= n) {
                    dp[i][M] = suffix[i];
                    continue;
                }

                /*
                 * We need to find the best number of stones
                 * the current player can obtain.
                 */
                int best = 0;

                /*
                 * We can choose X piles where:
                 *
                 *      1 <= X <= 2 * M
                 *
                 * but obviously we cannot take more piles
                 * than are remaining.
                 */
                for (int X = 1; X <= 2 * M && i + X <= n; X++) {

                    /*
                     * If we take X piles, we immediately get
                     * all stones in those X piles.
                     *
                     * The number of stones in the first X
                     * remaining piles is:
                     *
                     * suffix[i] - suffix[i + X]
                     */
                    int currentStones = suffix[i] - suffix[i + X];

                    /*
                     * After taking X piles:
                     *
                     * M becomes max(M, X)
                     *
                     * Then the opponent gets to play.
                     */
                    int newM = Math.max(M, X);

                    /*
                     * dp[i + X][newM] is the maximum number
                     * of stones the OPPONENT can get from
                     * the remaining piles.
                     */
                    int opponentStones = dp[i + X][newM];

                    /*
                     * There are suffix[i] total stones remaining.
                     *
                     * We take currentStones.
                     *
                     * The opponent will eventually take
                     * opponentStones.
                     *
                     * Therefore, the number of stones that
                     * WE can eventually get is:
                     *
                     * total remaining
                     * - opponent's eventual stones
                     *
                     * This is a very useful minimax trick.
                     */
                    int totalForUs = suffix[i] - opponentStones;

                    /*
                     * Try every possible X and keep the choice
                     * that gives the current player the maximum
                     * number of stones.
                     */
                    best = Math.max(best, totalForUs);
                }

                /*
                 * Store the best result for this state.
                 */
                dp[i][M] = best;
            }
        }

        /*
         * Alice starts at:
         *
         *   i = 0
         *   M = 1
         *
         * Therefore dp[0][1] is the maximum number
         * of stones Alice can obtain.
         */
        return dp[0][1];
    }
}