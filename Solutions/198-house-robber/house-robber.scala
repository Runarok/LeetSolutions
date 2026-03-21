object Solution {
    def rob(nums: Array[Int]): Int = {

        // Edge case: if no houses
        if (nums.isEmpty) return 0

        // Edge case: if only one house
        if (nums.length == 1) return nums(0)

        // prev1 = dp[i-1] → max money till previous house
        // prev2 = dp[i-2] → max money till house before previous
        var prev1 = 0
        var prev2 = 0

        // Iterate through each house
        for (money <- nums) {

            // Option 1: skip this house → prev1
            // Option 2: rob this house → prev2 + money
            val current = Math.max(prev1, prev2 + money)

            // Move forward:
            // prev2 becomes old prev1
            prev2 = prev1

            // prev1 becomes current result
            prev1 = current
        }

        // Final result
        prev1
    }
}