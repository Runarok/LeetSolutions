class Solution {
    func canPartitionGrid(_ grid: [[Int]]) -> Bool {
        let m = grid.count          // number of rows
        let n = grid[0].count       // number of columns
        
        // Step 1: Compute total sum of the grid
        var totalSum = 0
        for row in grid {
            for val in row {
                totalSum += val
            }
        }
        
        // If total sum is odd, we cannot split it into two equal parts
        if totalSum % 2 != 0 {
            return false
        }
        
        let target = totalSum / 2   // each partition must have this sum
        
        // ---------------------------------------------------------
        // Step 2: Try horizontal cuts
        // ---------------------------------------------------------
        var runningRowSum = 0
        
        // Iterate row by row
        // We stop at m-1 because the bottom part must be non-empty
        for i in 0..<m-1 {
            // Add current row sum
            runningRowSum += grid[i].reduce(0, +)
            
            // Check if top part equals target
            if runningRowSum == target {
                return true
            }
        }
        
        // ---------------------------------------------------------
        // Step 3: Try vertical cuts
        // ---------------------------------------------------------
        
        // Compute column sums first
        var colSums = Array(repeating: 0, count: n)
        
        // Fill column sums
        for i in 0..<m {
            for j in 0..<n {
                colSums[j] += grid[i][j]
            }
        }
        
        var runningColSum = 0
        
        // Try splitting column-wise
        // Stop at n-1 so right side is non-empty
        for j in 0..<n-1 {
            runningColSum += colSums[j]
            
            // Check if left part equals target
            if runningColSum == target {
                return true
            }
        }
        
        // If no valid cut found
        return false
    }
}