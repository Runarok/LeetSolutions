class Solution {
    fun twoSum(nums: IntArray, target: Int): IntArray? {
        val result = IntArray(2)  // Array of size 2 to store indices
        
        // Brute force checking to find the solution
        for (i in nums.indices) {
            for (j in i + 1 until nums.size) {
                if (nums[i] + nums[j] == target) {
                    result[0] = i
                    result[1] = j
                    return result
                }
            }
        }

        return null  // If no solution is found, return null
    }
}