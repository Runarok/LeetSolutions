object Solution {
    def rangeAddQueries(n: Int, queries: Array[Array[Int]]): Array[Array[Int]] = {

        // Difference matrix with padding (n+1 x n+1)
        val diff = Array.ofDim[Int](n + 1, n + 1)

        // Apply each query in O(1)
        for (q <- queries) {
            val (r1, c1, r2, c2) = (q(0), q(1), q(2), q(3))

            diff(r1)(c1) += 1
            if (c2 + 1 < n) diff(r1)(c2 + 1) -= 1
            if (r2 + 1 < n) diff(r2 + 1)(c1) -= 1
            if (r2 + 1 < n && c2 + 1 < n) diff(r2 + 1)(c2 + 1) += 1
        }

        // Convert difference matrix into actual matrix
        val mat = Array.ofDim[Int](n, n)

        // Prefix sum across rows
        for (i <- 0 until n) {
            for (j <- 1 until n) {
                diff(i)(j) += diff(i)(j - 1)
            }
        }

        // Prefix sum down columns
        for (j <- 0 until n) {
            for (i <- 1 until n) {
                diff(i)(j) += diff(i - 1)(j)
            }
        }

        // Copy first n x n region into result
        for (i <- 0 until n; j <- 0 until n) {
            mat(i)(j) = diff(i)(j)
        }

        mat
    }
}
