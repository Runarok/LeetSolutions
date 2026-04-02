class Solution {

    /**
     * @param Integer[][] $coins
     * @return Integer
     */
    function maximumAmount($coins) {
        $m = count($coins);
        $n = count($coins[0]);

        // dp[i][j][k] = max coins at (i,j) using k neutralizations
        // Initialize with very small numbers
        $dp = array_fill(0, $m, array_fill(0, $n, array_fill(0, 3, PHP_INT_MIN)));

        // ---- Base Case (0,0) ----
        if ($coins[0][0] >= 0) {
            // No robber, just take coins
            for ($k = 0; $k < 3; $k++) {
                $dp[0][0][$k] = $coins[0][0];
            }
        } else {
            // Robber case
            // Option 1: don't neutralize
            $dp[0][0][0] = $coins[0][0];

            // Option 2: neutralize (use 1 ability)
            $dp[0][0][1] = 0;

            // Option 3: also valid for k=2 (we used 1 out of 2)
            $dp[0][0][2] = 0;
        }

        // ---- Fill DP ----
        for ($i = 0; $i < $m; $i++) {
            for ($j = 0; $j < $n; $j++) {

                // Skip (0,0), already initialized
                if ($i == 0 && $j == 0) continue;

                for ($k = 0; $k < 3; $k++) {

                    // Try coming from top
                    if ($i > 0 && $dp[$i-1][$j][$k] != PHP_INT_MIN) {
                        $this->update($dp, $coins, $i, $j, $k, $dp[$i-1][$j][$k]);
                    }

                    // Try coming from left
                    if ($j > 0 && $dp[$i][$j-1][$k] != PHP_INT_MIN) {
                        $this->update($dp, $coins, $i, $j, $k, $dp[$i][$j-1][$k]);
                    }
                }
            }
        }

        // ---- Final Answer ----
        return max(
            $dp[$m-1][$n-1][0],
            $dp[$m-1][$n-1][1],
            $dp[$m-1][$n-1][2]
        );
    }

    /**
     * Helper function to update DP state
     */
    function update(&$dp, $coins, $i, $j, $k, $prevValue) {
        $cell = $coins[$i][$j];

        // Case 1: positive or zero
        if ($cell >= 0) {
            $dp[$i][$j][$k] = max(
                $dp[$i][$j][$k],
                $prevValue + $cell
            );
        } else {
            // Case 2: robber (negative)

            // Option 1: do NOT neutralize
            $dp[$i][$j][$k] = max(
                $dp[$i][$j][$k],
                $prevValue + $cell
            );

            // Option 2: neutralize (if we have remaining)
            if ($k < 2) {
                $dp[$i][$j][$k + 1] = max(
                    $dp[$i][$j][$k + 1],
                    $prevValue
                );
            }
        }
    }
}