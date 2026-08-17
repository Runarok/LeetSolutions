class Solution {
    fun longestSubsequence(nums: IntArray): Int {
        var xor = 0
        var hasNonZero = false

        for (num in nums) {
            xor = xor xor num
            if (num != 0) hasNonZero = true
        }

        return when {
            xor != 0 -> nums.size
            hasNonZero -> nums.size - 1
            else -> 0
        }
    }
}
