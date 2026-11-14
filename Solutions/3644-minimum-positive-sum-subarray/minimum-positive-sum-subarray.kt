
class Solution {
    fun minimumSumSubarray(nums: List<Int>, l: Int, r: Int): Int {

        // Get the size of the input array
        val n = nums.size

        // Prefix sum array:
        // prefix[i] stores the sum of elements from index 0 to i-1.
        //
        // Example:
        // nums   = [3, -2, 1, 4]
        // prefix = [0, 3, 1, 2, 6]
        //
        // This helps us calculate any subarray sum in O(1).
        val prefix = IntArray(n + 1)

        // Build the prefix sum array
        for (i in 0 until n) {
            prefix[i + 1] = prefix[i] + nums[i]
        }

        // Store the minimum positive subarray sum found so far.
        // Initially, no valid subarray has been found.
        var minSum = Int.MAX_VALUE

        // Try every possible starting index
        for (start in 0 until n) {

            // Try every possible subarray length between l and r
            for (length in l..r) {

                // Calculate the ending index (exclusive)
                val end = start + length

                // Make sure the subarray does not go outside the array
                if (end > n) {
                    break
                }

                // Calculate the subarray sum using prefix sums.
                //
                // Sum from index start to end-1:
                // prefix[end] - prefix[start]
                val sum = prefix[end] - prefix[start]

                // We only need subarrays whose sum is greater than 0.
                if (sum > 0) {

                    // Update the minimum positive sum
                    minSum = minOf(minSum, sum)
                }
            }
        }

        // If no valid positive subarray was found, return -1.
        // Otherwise, return the smallest positive sum.
        return if (minSum == Int.MAX_VALUE) -1 else minSum
    }
}
