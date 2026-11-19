
class Solution {
    fun minimizeSum(nums: IntArray): Int {

        // Get the number of elements in the array
        val n = nums.size

        // Sort the array in ascending order.
        // This helps us easily identify the smallest
        // and largest elements.
        nums.sort()

        // Case 1:
        // Change the two smallest elements.
        // The remaining elements range from nums[2]
        // to nums[n - 1].
        val case1 = nums[n - 1] - nums[2]

        // Case 2:
        // Change the smallest and largest elements.
        // The remaining elements range from nums[1]
        // to nums[n - 2].
        val case2 = nums[n - 2] - nums[1]

        // Case 3:
        // Change the two largest elements.
        // The remaining elements range from nums[0]
        // to nums[n - 3].
        val case3 = nums[n - 3] - nums[0]

        // Return the minimum possible score
        // among all three cases.
        return minOf(case1, case2, case3)
    }
}
