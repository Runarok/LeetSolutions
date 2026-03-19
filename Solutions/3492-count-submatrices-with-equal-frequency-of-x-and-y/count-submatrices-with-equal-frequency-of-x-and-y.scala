object Solution {
    def numberOfSubmatrices(grid: Array[Array[Char]]): Int = {
        
        val m = grid.length
        val n = grid(0).length
        
        // Prefix sum arrays for counting X and Y
        // prefixX(i)(j) = number of X's in rectangle (0,0) → (i-1,j-1)
        val prefixX = Array.ofDim[Int](m + 1, n + 1)
        val prefixY = Array.ofDim[Int](m + 1, n + 1)
        
        var result = 0
        
        // Build prefix sums
        for (i <- 1 to m) {
            for (j <- 1 to n) {
                
                // Carry forward previous sums
                prefixX(i)(j) = prefixX(i-1)(j) + prefixX(i)(j-1) - prefixX(i-1)(j-1)
                prefixY(i)(j) = prefixY(i-1)(j) + prefixY(i)(j-1) - prefixY(i-1)(j-1)
                
                // Add current cell contribution
                if (grid(i-1)(j-1) == 'X') {
                    prefixX(i)(j) += 1
                }
                else if (grid(i-1)(j-1) == 'Y') {
                    prefixY(i)(j) += 1
                }
                
                // Now we are considering submatrix (0,0) → (i-1,j-1)
                val countX = prefixX(i)(j)
                val countY = prefixY(i)(j)
                
                // Condition 1: equal number of X and Y
                // Condition 2: at least one X
                if (countX == countY && countX > 0) {
                    result += 1
                }
            }
        }
        
        result
    }
}