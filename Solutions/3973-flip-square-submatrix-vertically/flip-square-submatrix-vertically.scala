object Solution {
    def reverseSubmatrix(grid: Array[Array[Int]], x: Int, y: Int, k: Int): Array[Array[Int]] = {
        
        // Number of rows in the grid
        val m = grid.length
        
        // Number of columns in the grid
        val n = grid(0).length
        
        // We only need to iterate through half of the submatrix rows
        // because we are swapping top rows with bottom rows
        for (i <- 0 until k / 2) {
            
            // Current top row index inside the submatrix
            val topRow = x + i
            
            // Corresponding bottom row index inside the submatrix
            val bottomRow = x + k - 1 - i
            
            // Now swap elements column-wise within the submatrix
            for (j <- 0 until k) {
                
                // Actual column index in the grid
                val col = y + j
                
                // Swap the elements at (topRow, col) and (bottomRow, col)
                val temp = grid(topRow)(col)
                grid(topRow)(col) = grid(bottomRow)(col)
                grid(bottomRow)(col) = temp
            }
        }
        
        // Return the modified grid
        grid
    }
}