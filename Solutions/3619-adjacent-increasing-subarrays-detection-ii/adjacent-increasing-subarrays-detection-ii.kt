class Solution {
    fun maxIncreasingSubarrays(nums: List<Int>): Int {
        val n = nums.size
        
        // inc[i] will store the length of the longest strictly increasing
        // subarray starting at index i
        val inc = IntArray(n) { 1 }
        
        // Build the inc array from right to left
        // If nums[i] < nums[i+1], then inc[i] = inc[i+1] + 1
        for (i in n - 2 downTo 0) {
            if (nums[i] < nums[i + 1]) {
                inc[i] = inc[i + 1] + 1
            }
        }
        
        // We want to find the maximum k such that there are two adjacent
        // strictly increasing subarrays of length k
        // The maximum possible k is at most n/2 because two subarrays must fit
        var left = 1
        var right = n / 2
        var result = 0
        
        // Use binary search to efficiently find the maximum valid k
        while (left <= right) {
            val mid = (left + right) / 2
            var found = false
            
            // Check all possible starting indices i for the first subarray of length mid
            // and verify if the subarray starting at i + mid is also strictly increasing of length mid
            for (i in 0..n - 2 * mid) {
                // If both subarrays satisfy the strictly increasing condition
                if (inc[i] >= mid && inc[i + mid] >= mid) {
                    found = true
                    break
                }
            }
            
            if (found) {
                // If found, update result and try to find a bigger k
                result = mid
                left = mid + 1
            } else {
                // Otherwise try smaller k
                right = mid - 1
            }
        }
        
        return result
    }
}
