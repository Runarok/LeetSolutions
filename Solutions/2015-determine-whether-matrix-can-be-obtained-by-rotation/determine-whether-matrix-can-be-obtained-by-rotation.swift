class Solution {
    func findRotation(_ mat: [[Int]], _ target: [[Int]]) -> Bool {
        
        // Helper function to rotate matrix 90° clockwise
        func rotate(_ matrix: [[Int]]) -> [[Int]] {
            let n = matrix.count
            
            // Create an empty n x n matrix filled with 0s
            var rotated = Array(repeating: Array(repeating: 0, count: n), count: n)
            
            // Perform rotation
            // Mapping: (i, j) -> (j, n - 1 - i)
            for i in 0..<n {
                for j in 0..<n {
                    rotated[j][n - 1 - i] = matrix[i][j]
                }
            }
            
            return rotated
        }
        
        // Start with original matrix
        var current = mat
        
        // Try all 4 possible rotations
        for _ in 0..<4 {
            
            // Check if current matrix matches target
            if current == target {
                return true
            }
            
            // Rotate matrix by 90° clockwise
            current = rotate(current)
        }
        
        // If none of the rotations matched
        return false
    }
}