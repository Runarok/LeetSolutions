object Solution {
    def numberOfPaths(grid: Array[Array[Int]], k: Int): Int = {
        // ------------------------------
        // Constants and dimensions
        // ------------------------------
        val MOD = 1000000007
        val m = grid.length
        val n = grid(0).length

        // ------------------------------------------------------------
        // DP definition:
        //
        // dp[j][r] = number of ways to reach cell (currentRow, j)
        //            with a path sum % k == r
        //
        // We use only two rows of DP at a time:
        //   prevRow : dp for row i-1
        //   currRow : dp for row i
        //
        // Each row is an Array of size n, where each element is an
        // Array[Int] of size k (all remainders 0..k-1).
        // ------------------------------------------------------------

        // initialize prevRow (the DP row above the current row)
        val prevRow = Array.fill(n, k)(0)
        // initialize currRow (the DP row we are computing)
        val currRow = Array.fill(n, k)(0)

        // ------------------------------------------------------------
        // Fill DP row by row
        // ------------------------------------------------------------
        for (i <- 0 until m) {

            // Clear the currRow for this new row computation
            for (j <- 0 until n; r <- 0 until k)
                currRow(j)(r) = 0

            for (j <- 0 until n) {

                // The value at this cell
                val cellVal = grid(i)(j)

                // ----------------------------------------------------
                // Compute the base remainder for this cell
                // Every path that reaches (i,j) must include this cell.
                //
                // Any previous remainder 'oldR' will transition to:
                //    newR = (oldR + cellVal) % k
                //
                // ----------------------------------------------------

                if (i == 0 && j == 0) {
                    // Starting cell (0,0) has exactly one path:
                    val r0 = cellVal % k
                    currRow(0)(r0) = 1
                }
                else {
                    // ------------------------------------------------
                    // Transition from ABOVE: cell (i-1, j)
                    // ------------------------------------------------
                    if (i > 0) {
                        val fromAbove = prevRow(j)
                        var oldR = 0
                        while (oldR < k) {
                            val ways = fromAbove(oldR)
                            if (ways != 0) {
                                val newR = (oldR + cellVal) % k
                                currRow(j)(newR) = 
                                    (currRow(j)(newR) + ways) % MOD
                            }
                            oldR += 1
                        }
                    }

                    // ------------------------------------------------
                    // Transition from LEFT: cell (i, j-1)
                    // ------------------------------------------------
                    if (j > 0) {
                        val fromLeft = currRow(j - 1)
                        var oldR = 0
                        while (oldR < k) {
                            val ways = fromLeft(oldR)
                            if (ways != 0) {
                                val newR = (oldR + cellVal) % k
                                currRow(j)(newR) =
                                    (currRow(j)(newR) + ways) % MOD
                            }
                            oldR += 1
                        }
                    }
                }
            }

            // --------------------------------------------------------
            // Move currRow to prevRow for the next iteration.
            // Instead of copying deeply, we copy element-wise to reuse
            // allocated arrays and avoid extra allocations.
            // --------------------------------------------------------
            for (j <- 0 until n; r <- 0 until k)
                prevRow(j)(r) = currRow(j)(r)
        }

        // ------------------------------------------------------------
        // Our answer is: number of ways to reach (m-1, n-1)
        // with remainder 0 (i.e., sum divisible by k).
        // ------------------------------------------------------------
        prevRow(n - 1)(0)
    }
}
