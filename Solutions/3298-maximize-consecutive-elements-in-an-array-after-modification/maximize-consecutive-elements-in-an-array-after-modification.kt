
class Solution {
    fun maxSelectedElements(nums: IntArray): Int {

        // Sort the array so we process smaller numbers first.
        nums.sort()

        // dp[x] represents the maximum length of a consecutive
        // sequence ending with the value x.
        val dp = HashMap<Int, Int>()

        // Stores the maximum sequence length.
        var ans = 0

        // Process every number in sorted order.
        for (num in nums) {

            // Save the old DP values BEFORE updating them.
            // This is important because we have two choices:
            // 1. Keep num unchanged.
            // 2. Increase num by 1.
            val prev = dp[num] ?: 0

            // Case 1: Keep the current number unchanged.
            // Extend a sequence ending at num - 1.
            val keep = (dp[num - 1] ?: 0) + 1

            // Case 2: Increase the current number by 1.
            // Extend a sequence ending at num.
            val increase = prev + 1

            // Update the best sequence ending at num.
            dp[num] = maxOf(
                dp[num] ?: 0,
                keep
            )

            // Update the best sequence ending at num + 1.
            dp[num + 1] = maxOf(
                dp[num + 1] ?: 0,
                increase
            )

            // Update the global answer.
            ans = maxOf(
                ans,
                dp[num]!!,
                dp[num + 1]!!
            )
        }

        return ans
    }
}
