class Solution {
    // Helper DP function to compute max fruits collectable with allowed moves
    private fun dp(fruits: Array<IntArray>, n: Int): Int {
        val prev = IntArray(n) { Int.MIN_VALUE } // Previous row results
        val curr = IntArray(n) { Int.MIN_VALUE } // Current row results

        // Initialize bottom-right corner starting point
        prev[n - 1] = fruits[0][n - 1]

        // Process from row 1 to n - 2 (excluding first and last rows)
        for (i in 1 until n - 1) {
            for (j in maxOf(n - 1 - i, i + 1) until n) {
                var best = prev[j] // Stay in the same column
                if (j > 0) {
                    best = maxOf(best, prev[j - 1]) // Move from left
                }
                if (j + 1 < n) {
                    best = maxOf(best, prev[j + 1]) // Move from right
                }

                curr[j] = best + fruits[i][j] // Add current cell's fruit value
            }

            // Swap curr and prev for next iteration
            for (k in 0 until n) {
                prev[k] = curr[k]
                curr[k] = Int.MIN_VALUE // Reset curr for next row
            }
        }

        // Return the result in the bottom-right cell
        return prev[n - 1]
    }

    fun maxCollectedFruits(fruits: Array<IntArray>): Int {
        val n = fruits.size
        var total = 0

        // Step 1: Add the diagonal fruits (i.e., fruits[i][i])
        for (i in 0 until n) {
            total += fruits[i][i]
        }

        // Step 2: Run DP in original matrix
        total += dp(fruits, n)

        // Step 3: Transpose the matrix to simulate the reverse direction
        for (i in 0 until n) {
            for (j in 0 until i) {
                val temp = fruits[i][j]
                fruits[i][j] = fruits[j][i]
                fruits[j][i] = temp
            }
        }

        // Step 4: Run DP again on transposed matrix
        total += dp(fruits, n)

        return total
    }
}
