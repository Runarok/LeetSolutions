class Solution {
    fun waysToSplitArray(nums: IntArray): Int {
        // Convert each element to Long to safely handle large sums without overflow
        // Calculate the total sum of the array elements as a Long
        val totalSum = nums.map { it.toLong() }.sum()
        
        var prefixSum = 0L  // Use Long for prefix sum to avoid overflow
        var count = 0       // Count of valid splits
        
        // Iterate through the array until the second last element
        // because the split must leave at least one element on the right side
        for (i in 0 until nums.size - 1) {
            // Add current element (converted to Long) to prefixSum
            prefixSum += nums[i].toLong()
            
            // Check if the sum of the left part is greater than or equal to the sum of the right part
            // Using Long arithmetic ensures correctness even for large sums
            if (prefixSum >= totalSum - prefixSum) {
                count++  // Increment count if condition is satisfied
            }
        }
        
        // Return the total number of valid splits
        return count
    }
}
