class Solution {
    func constructProductMatrix(_ grid: [[Int]]) -> [[Int]] {
        
        let mod = 12345
        
        let n = grid.count
        let m = grid[0].count
        
        // Step 1: Flatten the 2D grid into 1D array
        var arr: [Int] = []
        for i in 0..<n {
            for j in 0..<m {
                arr.append(grid[i][j] % mod) // take mod early to prevent overflow
            }
        }
        
        let total = arr.count
        
        // Step 2: Create prefix array
        // prefix[i] = product of elements before i
        var prefix = Array(repeating: 1, count: total)
        for i in 1..<total {
            prefix[i] = (prefix[i - 1] * arr[i - 1]) % mod
        }
        
        // Step 3: Create suffix array
        // suffix[i] = product of elements after i
        var suffix = Array(repeating: 1, count: total)
        for i in stride(from: total - 2, through: 0, by: -1) {
            suffix[i] = (suffix[i + 1] * arr[i + 1]) % mod
        }
        
        // Step 4: Compute result using prefix * suffix
        var result1D = Array(repeating: 0, count: total)
        for i in 0..<total {
            result1D[i] = (prefix[i] * suffix[i]) % mod
        }
        
        // Step 5: Convert back to 2D matrix
        var result = Array(repeating: Array(repeating: 0, count: m), count: n)
        
        var index = 0
        for i in 0..<n {
            for j in 0..<m {
                result[i][j] = result1D[index]
                index += 1
            }
        }
        
        return result
    }
}