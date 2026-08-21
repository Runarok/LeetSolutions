class Solution {
    fun findKthSmallest(coins: IntArray, k: Int): Long {
        val n = coins.size
        val target = k.toLong()

        fun gcd(a: Long, b: Long): Long {
            var x = a
            var y = b
            while (y != 0L) {
                val t = x % y
                x = y
                y = t
            }
            return x
        }

        fun lcm(a: Long, b: Long): Long {
            return a / gcd(a, b) * b
        }

        // Number of positive integers <= x divisible by
        // at least one coin denomination.
        fun count(x: Long): Long {
            var result = 0L

            for (mask in 1 until (1 shl n)) {
                var multiple = 1L
                var bits = 0
                var valid = true

                for (i in 0 until n) {
                    if ((mask and (1 shl i)) != 0) {
                        bits++

                        multiple = lcm(multiple, coins[i].toLong())

                        // No need to continue if LCM > x.
                        if (multiple > x) {
                            valid = false
                            break
                        }
                    }
                }

                if (!valid) continue

                val cnt = x / multiple

                // Inclusion-exclusion:
                // odd number of coins -> add
                // even number of coins -> subtract
                if (bits % 2 == 1) {
                    result += cnt
                } else {
                    result -= cnt
                }
            }

            return result
        }

        var low = 1L
        var high = coins.minOrNull()!!.toLong() * target

        while (low < high) {
            val mid = low + (high - low) / 2

            if (count(mid) >= target) {
                high = mid
            } else {
                low = mid + 1
            }
        }

        return low
    }
}