class Solution {
    func colorTheArray(_ n: Int, _ queries: [[Int]]) -> [Int] {
        // Array to store colors
        var colors = Array(repeating: 0, count: n)
        
        // This will store the number of adjacent equal pairs
        var count = 0
        
        // Result array
        var result = [Int]()
        
        for query in queries {
            let index = query[0]
            let newColor = query[1]
            
            // Step 1: Remove contribution of old color
            let oldColor = colors[index]
            
            if oldColor != 0 {
                // Check left neighbor
                if index > 0 && colors[index - 1] == oldColor {
                    count -= 1
                }
                
                // Check right neighbor
                if index < n - 1 && colors[index + 1] == oldColor {
                    count -= 1
                }
            }
            
            // Step 2: Update the color
            colors[index] = newColor
            
            // Step 3: Add contribution of new color
            if newColor != 0 {
                // Check left neighbor
                if index > 0 && colors[index - 1] == newColor {
                    count += 1
                }
                
                // Check right neighbor
                if index < n - 1 && colors[index + 1] == newColor {
                    count += 1
                }
            }
            
            // Append current count after this query
            result.append(count)
        }
        
        return result
    }
}
