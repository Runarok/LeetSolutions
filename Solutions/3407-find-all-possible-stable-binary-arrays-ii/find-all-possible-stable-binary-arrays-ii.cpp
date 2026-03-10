class Solution {
public:
    const int MOD = 1e9+7;

    // dp[i][j][k]
    // i = number of zeros used
    // j = number of ones used
    // k = last element placed
    //     0 -> last element is zero
    //     1 -> last element is one
    int dp[1005][1005][2];

    int numberOfStableArrays(int zero, int one, int limit) {

        // Initialize DP array with 0
        memset(dp,0,sizeof(dp));

        // Base case:
        // If we only place zeros and no ones,
        // we can place at most 'limit' zeros consecutively
        for(int i=1;i<=min(zero,limit);i++)
            dp[i][0][0] = 1; // valid array ending with zero

        // Base case:
        // If we only place ones and no zeros,
        // we can place at most 'limit' ones consecutively
        for(int j=1;j<=min(one,limit);j++)
            dp[0][j][1] = 1; // valid array ending with one

        // Fill DP table
        for(int i=1;i<=zero;i++){
            for(int j=1;j<=one;j++){

                // ---------------------------
                // Case 1: Ending with zero
                // ---------------------------

                // We can append zero to arrays that previously ended with:
                // 1) zero
                // 2) one
                long long val0 = (1LL*dp[i-1][j][0] + dp[i-1][j][1]) % MOD;

                // But we must ensure we do not exceed 'limit' consecutive zeros
                // If we already had 'limit' zeros before,
                // we must subtract those invalid cases
                if(i-limit-1 >= 0)
                    val0 = (val0 - dp[i-limit-1][j][1] + MOD) % MOD;

                dp[i][j][0] = val0;

                // ---------------------------
                // Case 2: Ending with one
                // ---------------------------

                // Append one to arrays that previously ended with:
                // 1) one
                // 2) zero
                long long val1 = (1LL*dp[i][j-1][1] + dp[i][j-1][0]) % MOD;

                // Ensure we do not exceed 'limit' consecutive ones
                if(j-limit-1 >= 0)
                    val1 = (val1 - dp[i][j-limit-1][0] + MOD) % MOD;

                dp[i][j][1] = val1;
            }
        }

        // Final answer:
        // Arrays ending with zero OR one
        return (dp[zero][one][0] + dp[zero][one][1]) % MOD;
    }
};