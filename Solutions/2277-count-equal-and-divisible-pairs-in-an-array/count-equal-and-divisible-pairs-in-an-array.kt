class Solution {
    fun countPairs(nums: IntArray, k: Int): Int {
        val n = nums.size  // Get the size of the nums array
        var res = 0  // Initialize the result counter to store the number of valid pairs
        
        // Iterate over each pair of indices (i, j) where 0 <= i < j < n
        for (i in 0 until n - 1) {  
            for (j in i + 1 until n) {  
                
                // Check if the elements at indices i and j are equal
                // and if the product of the indices i and j is divisible by k
                if ((i * j) % k == 0 && nums[i] == nums[j]) {
                    res++  // If both conditions are met, increment the result counter
                }
            }
        }
        
        // Return the total number of valid pairs
        return res
    }
}
