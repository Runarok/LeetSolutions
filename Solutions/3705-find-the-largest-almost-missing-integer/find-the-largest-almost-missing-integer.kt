class Solution {
    fun largestInteger(nums: IntArray, k: Int): Int {
        val count = IntArray(51)

        // Count how many size-k subarrays contain each number.
        for (i in 0..nums.size - k) {
            val seen = BooleanArray(51)

            for (j in i until i + k) {
                seen[nums[j]] = true
            }

            for (x in 0..50) {
                if (seen[x]) {
                    count[x]++
                }
            }
        }

        // Find the largest number appearing in exactly one subarray.
        for (x in 50 downTo 0) {
            if (count[x] == 1) {
                return x
            }
        }

        return -1
    }
}