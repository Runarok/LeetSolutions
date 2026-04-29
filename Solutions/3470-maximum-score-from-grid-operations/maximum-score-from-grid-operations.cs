public class Solution {
    public long MaximumScore(int[][] grid) {

        int n = grid.Length;

        // If there is only 1 column, no adjacent column exists → score = 0
        if (n == 1) return 0;

        // ------------------------------------------------------------
        // STEP 1: Prefix sum for each column
        // colSum[c, r] = sum of grid[0..r-1][c]
        // Helps us quickly compute range sums in O(1)
        // ------------------------------------------------------------
        long[,] colSum = new long[n, n + 1];

        for (int c = 0; c < n; c++) {
            for (int r = 1; r <= n; r++) {
                colSum[c, r] = colSum[c, r - 1] + grid[r - 1][c];
            }
        }

        // ------------------------------------------------------------
        // STEP 2: DP Definition
        //
        // dp[i][currH][prevH] =
        // max score considering columns [0..i]
        // where:
        //   current column i has height currH
        //   previous column i-1 has height prevH
        //
        // Height means:
        //   rows [0..h-1] are BLACK
        //   rows [h..n-1] are WHITE
        // ------------------------------------------------------------
        long[,,] dp = new long[n, n + 1, n + 1];

        // ------------------------------------------------------------
        // STEP 3: Helper arrays for optimization
        //
        // These reduce transition from O(n) → O(1)
        //
        // prevMax  : prefix max (left → right)
        // prevSuffixMax : suffix max (right → left)
        // ------------------------------------------------------------
        long[,] prevMax = new long[n + 1, n + 1];
        long[,] prevSuffixMax = new long[n + 1, n + 1];

        // ------------------------------------------------------------
        // INITIALIZATION (column 0)
        // No contribution yet because no left neighbor
        // ------------------------------------------------------------
        for (int currH = 0; currH <= n; currH++) {
            for (int prevH = 0; prevH <= n; prevH++) {
                dp[0, currH, prevH] = 0;
                prevMax[currH, prevH] = 0;
                prevSuffixMax[currH, prevH] = 0;
            }
        }

        // ------------------------------------------------------------
        // STEP 4: Process columns from left → right
        // ------------------------------------------------------------
        for (int i = 1; i < n; i++) {

            // Try all possible current heights
            for (int currH = 0; currH <= n; currH++) {

                // Try all possible previous heights
                for (int prevH = 0; prevH <= n; prevH++) {

                    if (currH <= prevH) {
                        // ==================================================
                        // CASE 1: previous column is taller
                        //
                        // rows [currH .. prevH-1] in CURRENT column:
                        //   - white in current (since > currH)
                        //   - black in previous (since <= prevH)
                        // → these contribute to score
                        // ==================================================
                        long extraScore = colSum[i, prevH] - colSum[i, currH];

                        // Use suffix max to get best previous DP quickly
                        dp[i, currH, prevH] =
                            prevSuffixMax[prevH, 0] + extraScore;

                    } else {
                        // ==================================================
                        // CASE 2: current column is taller
                        //
                        // rows [prevH .. currH-1] in PREVIOUS column:
                        //   - white in previous
                        //   - black in current
                        // → contribute to score
                        // ==================================================
                        long extraScore =
                            colSum[i - 1, currH] - colSum[i - 1, prevH];

                        // Two possibilities:
                        // 1. No contribution case
                        long option1 = prevSuffixMax[prevH, currH];

                        // 2. Add contribution from previous column
                        long option2 = prevMax[prevH, currH] + extraScore;

                        dp[i, currH, prevH] = Math.Max(option1, option2);
                    }
                }
            }

            // ------------------------------------------------------------
            // STEP 5: Build helper arrays for next iteration
            // ------------------------------------------------------------
            for (int currH = 0; currH <= n; currH++) {

                // ---------- PREFIX MAX ----------
                prevMax[currH, 0] = dp[i, currH, 0];

                for (int prevH = 1; prevH <= n; prevH++) {

                    // If prevH > currH, we previously added extraScore
                    // which must be neutralized here (penalty correction)
                    long penalty = (prevH > currH)
                        ? (colSum[i, prevH] - colSum[i, currH])
                        : 0;

                    prevMax[currH, prevH] = Math.Max(
                        prevMax[currH, prevH - 1],
                        dp[i, currH, prevH] - penalty
                    );
                }

                // ---------- SUFFIX MAX ----------
                prevSuffixMax[currH, n] = dp[i, currH, n];

                for (int prevH = n - 1; prevH >= 0; prevH--) {
                    prevSuffixMax[currH, prevH] = Math.Max(
                        prevSuffixMax[currH, prevH + 1],
                        dp[i, currH, prevH]
                    );
                }
            }
        }

        // ------------------------------------------------------------
        // STEP 6: Extract answer
        //
        // Last column:
        // Only heights 0 or n matter (fully white or fully black)
        // ------------------------------------------------------------
        long ans = 0;

        for (int k = 0; k <= n; k++) {
            ans = Math.Max(ans,
                Math.Max(dp[n - 1, 0, k],   // last column all white
                         dp[n - 1, n, k])   // last column all black
            );
        }

        return ans;
    }
}