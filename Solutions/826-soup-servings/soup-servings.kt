class Solution {
    fun soupServings(n: Int): Double {
        if (n >= 4800) return 1.0 // Optimization: when n is large enough, result is nearly 1

        val m = Math.ceil(n / 25.0).toInt() // Normalize by 25ml
        val dp = mutableMapOf<Int, MutableMap<Int, Double>>() // Memoization map

        // Helper function to safely get value from dp, default to 0.0
        fun get(i: Int, j: Int): Double {
            return dp.getOrPut(i) { mutableMapOf() }.getOrDefault(j, 0.0)
        }

        // Simulate the 4 serving operations and average their results
        fun calculateDP(i: Int, j: Int): Double {
            return (
                get((i - 4).coerceAtLeast(0), j) +
                get((i - 3).coerceAtLeast(0), j - 1) +
                get((i - 2).coerceAtLeast(0), (j - 2).coerceAtLeast(0)) +
                get(i - 1, (j - 3).coerceAtLeast(0))
            ) / 4.0
        }

        dp[0] = mutableMapOf(0 to 0.5) // Both empty → 0.5 probability

        for (k in 1..m) {
            dp.getOrPut(0) { mutableMapOf() }[k] = 1.0 // A empty first
            dp.getOrPut(k) { mutableMapOf() }[0] = 0.0 // B empty first

            for (j in 1..k) {
                dp.getOrPut(j) { mutableMapOf() }[k] = calculateDP(j, k)
                dp.getOrPut(k) { mutableMapOf() }[j] = calculateDP(k, j)
            }

            if (get(k, k) > 1 - 1e-5) return 1.0 // Early stop if sufficiently close to 1
        }

        return get(m, m) // Return probability for full amount
    }
}
