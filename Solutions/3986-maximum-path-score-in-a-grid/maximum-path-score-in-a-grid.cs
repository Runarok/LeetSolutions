public class Solution {
    public int MaxPathScore(int[][] grid, int k) {
        int m = grid.Length;
        int n = grid[0].Length;

        // dp[i][j][c] = max score at (i,j) with cost c
        // We use jagged arrays to save space
        int[][][] dp = new int[m][][];
        
        for (int i = 0; i < m; i++) {
            dp[i] = new int[n][];
            for (int j = 0; j < n; j++) {
                dp[i][j] = new int[k + 1];
                
                // Initialize with -1 (means unreachable state)
                for (int c = 0; c <= k; c++) {
                    dp[i][j][c] = -1;
                }
            }
        }

        // Starting point (0,0)
        // grid[0][0] = 0 → score = 0, cost = 0
        dp[0][0][0] = 0;

        // Traverse the grid
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {

                // Skip start cell (already initialized)
                if (i == 0 && j == 0) continue;

                // Determine score and cost of current cell
                int scoreGain = grid[i][j];
                int costGain = (grid[i][j] == 0) ? 0 : 1;

                // Try all possible previous costs
                for (int c = 0; c <= k; c++) {
                    if (dp[i][j][c] != -1) continue; // already set (optional optimization)
                }

                // Try transitions from top and left
                for (int c = 0; c <= k; c++) {

                    // FROM TOP (i-1, j)
                    if (i > 0 && dp[i - 1][j][c] != -1) {
                        int newCost = c + costGain;

                        // Only valid if within budget
                        if (newCost <= k) {
                            int newScore = dp[i - 1][j][c] + scoreGain;

                            dp[i][j][newCost] = Math.Max(dp[i][j][newCost], newScore);
                        }
                    }

                    // FROM LEFT (i, j-1)
                    if (j > 0 && dp[i][j - 1][c] != -1) {
                        int newCost = c + costGain;

                        if (newCost <= k) {
                            int newScore = dp[i][j - 1][c] + scoreGain;

                            dp[i][j][newCost] = Math.Max(dp[i][j][newCost], newScore);
                        }
                    }
                }
            }
        }

        // Find best score at destination within cost ≤ k
        int result = -1;

        for (int c = 0; c <= k; c++) {
            result = Math.Max(result, dp[m - 1][n - 1][c]);
        }

        return result;
    }
}