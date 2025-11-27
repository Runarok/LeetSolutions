object Solution {
    def maxSubarraySum(nums: Array[Int], k: Int): Long = {
        val n = nums.length
        val minPref = Array.fill[Long](k)(Long.MaxValue)
        
        var prefix: Long = 0L
        var ans: Long = Long.MinValue
        
        // prefix[0] = 0 occurs at index 0 → remainder is 0
        minPref(0) = 0L
        
        for (i <- 0 until n) {
            prefix += nums(i)
            val r = (i + 1) % k

            // check candidate
            if (minPref(r) != Long.MaxValue) {
                ans = math.max(ans, prefix - minPref(r))
            }

            // update minimum prefix sum for this remainder
            minPref(r) = math.min(minPref(r), prefix)
        }

        ans
    }
}
