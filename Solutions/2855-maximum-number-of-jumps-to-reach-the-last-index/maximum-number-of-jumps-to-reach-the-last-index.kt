import kotlin.math.abs
import kotlin.math.max

class Solution {
    fun maximumJumps(nums: IntArray, target: Int): Int {
        val n = nums.size
        // Initialize DP array with -1 to represent unreachable indices
        val dp = IntArray(n) { -1 }
        
        // Base case: 0 jumps are needed to start at the first index
        dp[0] = 0
        
        // Iterate through each index j to find the max jumps to reach it
        for (j in 1 until n) {
            // Check all previous indices i for a valid jump to j
            for (i in 0 until j) {
                // Check if index i was reachable and if the jump to j is valid
                if (dp[i] != -1 && abs(nums[j] - nums[i]) <= target) {
                    dp[j] = max(dp[j], dp[i] + 1)
                }
            }
        }
        
        // Return the max jumps to the last index or -1 if unreachable
        return dp[n - 1]
    }
}
