class Solution {
    func firstCompleteIndex(_ arr: [Int], _ mat: [[Int]]) -> Int {
        let m = mat.count
        let n = mat[0].count
        
        // Step 1: Mapping values to their coordinates
        var position = [Int: (Int, Int)]()  // value -> (row, col)
        for i in 0..<m {
            for j in 0..<n {
                position[mat[i][j]] = (i, j)
            }
        }
        
        // Step 2: Track painted rows and columns
        var rowCount = [Int](repeating: 0, count: m)
        var colCount = [Int](repeating: 0, count: n)
        
        // Step 3: Process arr
        for (index, num) in arr.enumerated() {
            if let (row, col) = position[num] {
                rowCount[row] += 1
                colCount[col] += 1
                
                // Step 4: Check for fully painted row or column
                if rowCount[row] == n || colCount[col] == m {
                    return index
                }
            }
        }
        
        return -1  // In case no complete row or column is found
    }
}
