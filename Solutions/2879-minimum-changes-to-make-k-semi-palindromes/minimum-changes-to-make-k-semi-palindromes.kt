
class Solution {
    fun minimumChanges(s: String, k: Int): Int {

        val n = s.length

        // --------------------------------------------------
        // STEP 1: Precompute the cost of making every
        // substring s[i...j] a semi-palindrome.
        // --------------------------------------------------

        // cost[i][j] stores the minimum number of character
        // changes needed to make substring s[i...j]
        // a semi-palindrome.
        //
        // Initially, all costs are set to a large value.
        val cost = Array(n) { IntArray(n) { Int.MAX_VALUE / 2 } }

        // Try every possible substring.
        for (i in 0 until n) {
            for (j in i + 1 until n) {

                // Length of the current substring.
                val len = j - i + 1

                // A semi-palindrome must have a valid divisor
                // d such that:
                // 1 <= d < len
                // len % d == 0
                //
                // Each divisor represents one possible
                // repeating pattern length.
                for (d in 1 until len) {

                    // Only consider divisors of the length.
                    if (len % d != 0) continue

                    // Number of groups formed using divisor d.
                    val groups = d

                    // Minimum changes for this divisor.
                    var changes = 0

                    // ------------------------------------------------
                    // STEP 2: Check each group independently.
                    //
                    // Group g contains characters at positions:
                    // i + g, i + g + d, i + g + 2*d, ...
                    //
                    // Every group must become a palindrome.
                    // ------------------------------------------------

                    for (g in 0 until groups) {

                        // Left pointer of the current group.
                        var left = i + g

                        // Right pointer of the current group.
                        //
                        // Since the substring ends at j,
                        // the last element of this group is:
                        // i + g + (len / d - 1) * d
                        var right = i + g + (len / d - 1) * d

                        // Compare symmetric characters in this group.
                        while (left < right) {

                            // If characters are different,
                            // at least one character must be changed.
                            if (s[left] != s[right]) {
                                changes++
                            }

                            // Move towards the center.
                            left += d
                            right -= d
                        }
                    }

                    // Keep the minimum cost among all valid divisors.
                    cost[i][j] = minOf(cost[i][j], changes)
                }
            }
        }

        // --------------------------------------------------
        // STEP 3: Dynamic Programming.
        //
        // dp[p][i] =
        // Minimum changes needed to partition the first i
        // characters into exactly p semi-palindromic substrings.
        // --------------------------------------------------

        val INF = Int.MAX_VALUE / 2

        val dp = Array(k + 1) { IntArray(n + 1) { INF } }

        // Base case:
        // Zero characters divided into zero substrings
        // requires zero changes.
        dp[0][0] = 0

        // Try creating exactly p substrings.
        for (p in 1..k) {

            // We need at least 2 characters per substring.
            //
            // Therefore, p substrings require at least 2*p
            // characters.
            for (i in (2 * p)..n) {

                // Try every possible starting position
                // of the last substring.
                //
                // Last substring will be s[start...i-1].
                //
                // It must contain at least 2 characters.
                for (start in (2 * (p - 1)) until i - 1) {

                    // Previous p-1 substrings cover
                    // the first 'start' characters.
                    val previous = dp[p - 1][start]

                    // Skip impossible previous partitions.
                    if (previous == INF) continue

                    // Cost of making the last substring
                    // s[start...i-1] a semi-palindrome.
                    val current = cost[start][i - 1]

                    // Update the minimum cost.
                    dp[p][i] = minOf(
                        dp[p][i],
                        previous + current
                    )
                }
            }
        }

        // Return minimum changes to partition the entire
        // string into exactly k semi-palindromic substrings.
        return dp[k][n]
    }
}
