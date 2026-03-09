class Solution {
    public int numberOfStableArrays(int zero, int one, int limit) {
        final int mod = 1_000_000_007;

        // dp0[i][j] -> number of arrays using i zeros and j ones, ending with 0
        int[][] dp0 = new int[zero + 1][one + 1];

        // dp1[i][j] -> number of arrays using i zeros and j ones, ending with 1
        int[][] dp1 = new int[zero + 1][one + 1];

        // Base case:
        // If the array contains only zeros and its length <= limit,
        // there is exactly one valid arrangement
        for (int i = 1; i <= Math.min(zero, limit); ++i)
            dp0[i][0] = 1;

        // If the array contains only ones and its length <= limit,
        // there is exactly one valid arrangement
        for (int j = 1; j <= Math.min(one, limit); ++j)
            dp1[0][j] = 1;

        // Build DP table
        for (int i = 1; i <= zero; ++i) {
            for (int j = 1; j <= one; ++j) {

                // Try placing k consecutive zeros (1 ≤ k ≤ limit)
                // before the current position
                for (int k = 1; k <= Math.min(limit, i); ++k)
                    dp0[i][j] = (dp0[i][j] + dp1[i - k][j]) % mod;

                // Try placing k consecutive ones (1 ≤ k ≤ limit)
                // before the current position
                for (int k = 1; k <= Math.min(limit, j); ++k)
                    dp1[i][j] = (dp1[i][j] + dp0[i][j - k]) % mod;
            }
        }

        // Total valid arrays = arrays ending with 0 + arrays ending with 1
        return (dp0[zero][one] + dp1[zero][one]) % mod;
    }
}