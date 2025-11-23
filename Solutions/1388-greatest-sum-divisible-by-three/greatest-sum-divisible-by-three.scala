object Solution {
    def maxSumDivThree(nums: Array[Int]): Int = {
        
        /***********************************************************************
         * dp(r) will store the BEST (maximum) sum we can make so far such that
         * the sum % 3 = r.
         *
         * There are only 3 possible remainders when dividing by 3:
         * r = 0 → sum is divisible by 3
         * r = 1 → sum leaves remainder 1
         * r = 2 → sum leaves remainder 2
         *
         * We want dp(0) at the end because that is the largest sum divisible by 3.
         *
         * Initially:
         *   - dp(0) = 0   → sum = 0 is valid and divisible by 3
         *   - dp(1) = -∞  → impossible initially
         *   - dp(2) = -∞  → impossible initially
         *
         * We use Int.MinValue/2 instead of Int.MinValue to avoid overflow
         * when adding values.
         ***********************************************************************/
        var dp = Array(0, Int.MinValue / 2, Int.MinValue / 2)


        /***********************************************************************
         * We iterate through each number in the array.
         * For every number `x`, we try to add it to EACH of the previously
         * achievable dp states. But we MUST use an auxiliary array (next) because
         * updates must NOT affect other updates inside the same iteration.
         ***********************************************************************/
        for (x <- nums) {

            // Make a copy so we can compute new states while referencing old ones
            val next = dp.clone()


            /*******************************************************************
             * For each remainder r = 0, 1, 2:
             * Check if the old dp(r) is valid. If dp(r) is valid, then:
             *
             * We can form a new sum:
             *   newSum = dp(r) + x
             *
             * And this sum will have a new remainder:
             *   newRemainder = (r + (x % 3)) % 3
             *
             * This is because:
             * (sum % 3 + x % 3) % 3 = (sum + x) % 3
             *******************************************************************/
            for (r <- 0 until 3) {

                // Only proceed if dp(r) is a valid sum (not negative infinity)
                if (dp(r) > Int.MinValue / 3) {

                    // Compute the new remainder after adding x to a remainder-r sum
                    val nr = (r + (x % 3)) % 3

                    // Update the best possible sum for this new remainder
                    // We take max because we want the maximum sum achievable.
                    next(nr) = math.max(next(nr), dp(r) + x)
                }
            }

            // Move forward with updated dp for the next iteration
            dp = next
        }

        /***********************************************************************
         * At the very end:
         * dp(0) contains the MAXIMUM POSSIBLE sum divisible by 3.
         ***********************************************************************/
        dp(0)
    }
}
