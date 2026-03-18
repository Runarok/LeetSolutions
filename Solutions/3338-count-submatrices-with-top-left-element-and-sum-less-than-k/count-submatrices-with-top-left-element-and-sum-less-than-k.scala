object Solution {
    def countSubmatrices(grid: Array[Array[Int]], k: Int): Int = {
        
        // Number of rows
        val m = grid.length
        
        // Number of columns
        val n = grid(0).length
        
        // This will store our answer
        var count = 0
        
        // Traverse each cell of the grid
        for (i <- 0 until m) {
            for (j <- 0 until n) {
                
                // Start with the current cell value
                var sum = grid(i)(j)
                
                // If we are not in the first row,
                // add the prefix sum from the cell above
                if (i > 0) {
                    sum += grid(i - 1)(j)
                }
                
                // If we are not in the first column,
                // add the prefix sum from the left cell
                if (j > 0) {
                    sum += grid(i)(j - 1)
                }
                
                // If we are not in first row and first column,
                // subtract the overlap (top-left diagonal)
                if (i > 0 && j > 0) {
                    sum -= grid(i - 1)(j - 1)
                }
                
                // Store the computed prefix sum back into the grid
                grid(i)(j) = sum
                
                // If this prefix sum (i.e., submatrix from (0,0) to (i,j))
                // is less than or equal to k, it is valid
                if (sum <= k) {
                    count += 1
                }
            }
        }
        
        // Return the total count of valid submatrices
        count
    }
}