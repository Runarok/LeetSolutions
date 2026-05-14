class Solution {
    fun isGood(nums: IntArray): Boolean {

        // Sort the array so we can easily check the pattern
        nums.sort()

        // The largest number should be n
        val n = nums[nums.size - 1]

        // A good array must have length n + 1
        // because base[n] = [1,2,3,...,n,n]
        if (nums.size != n + 1) {
            return false
        }

        // Check numbers from 1 to n-1
        // They should appear exactly once
        for (i in 0 until n - 1) {

            // After sorting:
            // nums[0] should be 1
            // nums[1] should be 2
            // nums[2] should be 3
            // ...
            if (nums[i] != i + 1) {
                return false
            }
        }

        // Last two elements must both be n
        if (nums[n - 1] != n || nums[n] != n) {
            return false
        }

        // All conditions satisfied
        return true
    }
}