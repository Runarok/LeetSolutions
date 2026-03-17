object Solution {
    def largestSubmatrix(matrix: Array[Array[Int]]): Int = {
        
        // number of rows
        val m = matrix.length
        
        // number of columns
        val n = matrix(0).length
        
        // this will store the maximum area found
        var maxArea = 0
        
        // ------------------------------------------------------
        // STEP 1: Build heights of consecutive 1s column-wise
        // ------------------------------------------------------
        // For each cell, convert it into the height of consecutive
        // ones ending at that row.
        //
        // Example:
        // matrix:
        // 1 0 1
        // 1 1 1
        //
        // becomes heights:
        // 1 0 1
        // 2 1 2
        //
        // because we accumulate vertical 1s
        // ------------------------------------------------------
        
        for (i <- 1 until m) {             // start from second row
            for (j <- 0 until n) {         // iterate each column
                
                // if current cell is 1, accumulate height
                if (matrix(i)(j) == 1) {
                    matrix(i)(j) += matrix(i - 1)(j)
                }
                // if it is 0 we keep it 0 (height reset)
            }
        }
        
        // ------------------------------------------------------
        // STEP 2: For each row treat it like a histogram
        // ------------------------------------------------------
        for (i <- 0 until m) {
            
            // copy the row
            val row = matrix(i).clone()
            
            // sort heights descending because we can reorder columns
            scala.util.Sorting.quickSort(row)
            val sorted = row.reverse
            
            // --------------------------------------------------
            // STEP 3: compute area for each possible width
            // --------------------------------------------------
            // width = number of columns used
            // height = minimum height among them
            //
            // Since sorted descending, sorted(j) is the smallest
            // height if we take first (j+1) columns
            // --------------------------------------------------
            
            for (j <- 0 until n) {
                
                // height of rectangle
                val height = sorted(j)
                
                // width of rectangle
                val width = j + 1
                
                // compute area
                val area = height * width
                
                // update maximum area
                maxArea = math.max(maxArea, area)
            }
        }
        
        // return final maximum area
        maxArea
    }
}