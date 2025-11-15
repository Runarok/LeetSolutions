object Solution {
    def numberOfSubstrings(s: String): Int = {

        val n = s.length
        // pre[j] = index of nearest '0' at or before (j-1)
        // pre[0] = -1 sentinel
        val pre = Array.ofDim[Int](n + 1)
        pre(0) = -1

        // Build pre[] exactly like the JS version
        for (i <- 0 until n) {
            if (i == 0 || s(i - 1) == '0') {
                // if s[i-1] is '0', then nearest zero at position i-1
                pre(i + 1) = i
            } else {
                // otherwise carry the previous nearest zero index
                pre(i + 1) = pre(i)
            }
        }

        var res = 0

        // Iterate over right boundary i = 1..n
        for (i <- 1 to n) {

            // cnt0 = number of zeros so far in this substring being expanded
            var cnt0 = if (s(i - 1) == '0') 1 else 0

            // j walks leftwards, jumping between 0-positions using pre[]
            var j = i

            // Same loop condition as JS:
            // continue walking left while j > 0 and cnt0^2 <= n
            // (cnt0^2 <= n is a safe pruning bound)
            while (j > 0 && cnt0 * cnt0 <= n) {

                // cnt1 = number of ones in substring (j..i)
                // Formula identical to JS: i - pre[j] - cnt0
                val cnt1 = i - pre(j) - cnt0

                // Check the dominant-ones condition
                if (cnt0 * cnt0 <= cnt1) {
                    // how many valid left boundaries?
                    val maxLeft = j - pre(j)
                    val extraAllowed = cnt1 - cnt0 * cnt0 + 1
                    res += math.min(maxLeft, extraAllowed)
                }

                // Move j left to the next zero position
                j = pre(j)

                // We increased zeros by 1
                cnt0 += 1
            }
        }

        res
    }
}
