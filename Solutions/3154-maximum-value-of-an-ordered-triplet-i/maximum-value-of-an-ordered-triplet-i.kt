class Solution {
    fun maximumTripletValue(nums: IntArray): Long {
        val n = nums.size
        var res: Long = 0

        // Iterate through all possible triplets (i, j, k)
        for (i in 0 until n) {               // Outer loop for index i
            for (j in i + 1 until n) {       // Middle loop for index j (i < j)
                for (k in j + 1 until n) {   // Inner loop for index k (j < k)
                    // Calculate the triplet value and update res if it's larger
                    res = maxOf(res, (nums[i] - nums[j]).toLong() * nums[k])
                }
            }
        }
        return res
    }
}
