class Solution {

    val MOD = 1_000_000_007  // Modulo value as per the problem

    // Fast exponentiation function: computes (x^y) % mod
    fun quickmul(x: Long, y: Long, mod: Int): Long {
        var res = 1L
        var base = x % mod
        var exp = y
        while (exp > 0) {
            if ((exp and 1L) == 1L) res = res * base % mod
            base = base * base % mod
            exp = exp shr 1
        }
        return res
    }

    fun magicalSum(m: Int, k: Int, nums: IntArray): Int {
        val n = nums.size  // Number of elements in nums

        // Precompute factorials and inverse factorials
        val fac = LongArray(m + 1) { 1L }
        val ifac = LongArray(m + 1) { 1L }
        for (i in 1..m) fac[i] = fac[i - 1] * i % MOD  // Compute factorials
        for (i in 2..m) ifac[i] = quickmul(i.toLong(), (MOD - 2).toLong(), MOD)  // Modular inverses
        for (i in 2..m) ifac[i] = ifac[i - 1] * ifac[i] % MOD  // Build full inverse factorials

        // Precompute numsPower[i][j] = nums[i]^j % MOD
        val numsPower = Array(n) { LongArray(m + 1) { 1L } }
        for (i in 0 until n) {
            for (j in 1..m) numsPower[i][j] = numsPower[i][j - 1] * nums[i] % MOD
        }

        // Initialize DP table: f[i][j][p][q]
        // i: current index in nums
        // j: total elements picked
        // p: compressed power sum index
        // q: number of carry-over set bits
        val f = Array(n) {
            Array(m + 1) {
                Array(m * 2 + 1) {
                    LongArray(k + 1)
                }
            }
        }

        // Base case: pick j elements from nums[0]
        for (j in 0..m) {
            f[0][j][j][0] = numsPower[0][j] * ifac[j] % MOD  // Store value after accounting for order
        }

        // DP transition
        for (i in 0 until n - 1) {
            for (j in 0..m) {
                for (p in 0..(m * 2)) {
                    for (q in 0..k) {
                        val cur = f[i][j][p][q]
                        if (cur == 0L) continue  // Skip if no valid sequence so far
                        val q2 = (p % 2) + q  // Add carry bit from LSB
                        if (q2 > k) break  // Prune if exceeds max allowed set bits
                        for (r in 0..(m - j)) {  // r = elements picked from nums[i+1]
                            val p2 = (p / 2) + r  // Shift + add new powers
                            if (p2 > m * 2) continue
                            val add = cur * numsPower[i + 1][r] % MOD * ifac[r] % MOD
                            f[i + 1][j + r][p2][q2] = (f[i + 1][j + r][p2][q2] + add) % MOD
                        }
                    }
                }
            }
        }

        // Final result: sum over valid final states with exactly k set bits
        var res = 0L
        for (p in 0..(m * 2)) {
            for (q in 0..k) {
                if (Integer.bitCount(p) + q == k) {
                    res = (res + f[n - 1][m][p][q] * fac[m] % MOD) % MOD
                }
            }
        }

        return res.toInt()
    }
}
