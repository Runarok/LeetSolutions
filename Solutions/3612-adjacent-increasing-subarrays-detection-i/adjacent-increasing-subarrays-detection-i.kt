class Solution {
    fun hasIncreasingSubarrays(nums: List<Int>, k: Int): Boolean {
        
        // Helper function to check if nums[start..start + k - 1] is strictly increasing
        fun isStrictlyIncreasing(start: Int): Boolean {
            for (i in start until start + k - 1) {
                if (nums[i] >= nums[i + 1]) {
                    // Not strictly increasing if current number is not less than next
                    return false
                }
            }
            return true
        }

        // Loop through all possible starting indices of the first subarray
        // We stop at nums.size - 2k because we need space for two subarrays of size k
        for (i in 0..nums.size - 2 * k) {
            val firstStart = i
            val secondStart = i + k

            // Check both subarrays starting at i and i + k
            if (isStrictlyIncreasing(firstStart) && isStrictlyIncreasing(secondStart)) {
                // Found two adjacent strictly increasing subarrays
                return true
            }
        }

        // No such pair found
        return false
    }
}
