class Solution {

    /**
     * @param Integer[] $nums
     * @param Integer $k
     * @return Integer
     */
    function countPartitions($nums, $k) {
        $MOD = 1_000_000_007;
        $n = count($nums);

        // dp[i] = number of ways to partition prefix nums[0..i-1]
        $dp = array_fill(0, $n + 1, 0);
        $dp[0] = 1;   // Empty prefix has one valid partition

        // Prefix sums: prefix[i] = dp[0] + dp[1] + ... + dp[i-1]
        $prefix = array_fill(0, $n + 1, 0);
        $prefix[0] = 0;
        $prefix[1] = 1; // prefix[1] = dp[0]

        // Monotonic deques for sliding window max/min
        $maxDQ = []; // decreasing deque storing indices
        $minDQ = []; // increasing deque storing indices

        $l = 0;

        for ($r = 0; $r < $n; $r++) {

            // --- Insert nums[r] into max deque ---
            while (!empty($maxDQ) && $nums[end($maxDQ)] <= $nums[$r]) {
                array_pop($maxDQ);
            }
            $maxDQ[] = $r;

            // --- Insert nums[r] into min deque ---
            while (!empty($minDQ) && $nums[end($minDQ)] >= $nums[$r]) {
                array_pop($minDQ);
            }
            $minDQ[] = $r;

            // --- Shrink window from left while invalid ---
            while ($nums[$maxDQ[0]] - $nums[$minDQ[0]] > $k) {

                // Move left boundary forward
                if ($maxDQ[0] == $l) array_shift($maxDQ);
                if ($minDQ[0] == $l) array_shift($minDQ);

                $l++;
            }

            // dp[r+1] = sum(dp[l] ... dp[r])  
            // = prefix[r+1] - prefix[l]
            $total = ($prefix[$r + 1] - $prefix[$l]) % $MOD;
            if ($total < 0) $total += $MOD;

            $dp[$r + 1] = $total;

            // Update prefix sum: prefix[i+1] = prefix[i] + dp[i]
            $prefix[$r + 2] = ($prefix[$r + 1] + $dp[$r + 1]) % $MOD;
        }

        return $dp[$n];
    }
}
