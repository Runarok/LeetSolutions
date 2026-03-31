class Solution {
    func generateString(_ s: String, _ t: String) -> String {
        // Convert strings to arrays for easy index access
        let sArr = Array(s)
        let tArr = Array(t)
        
        // n = length of s, m = length of t
        let n = sArr.count, m = tArr.count
        
        // Result array of size (n + m - 1), initialized with '?'
        // '?' means "not decided yet"
        var ans = Array(repeating: Character("?"), count: n + m - 1)
        
        // STEP 1: Handle all 'T' constraints
        // If s[i] == 'T', then substring starting at i must match t exactly
        for i in 0..<n {
            if sArr[i] != "T" { continue }
            
            // Try to force t into ans at position i
            for j in 0..<m {
                let v = ans[i + j]
                
                // If already assigned and conflicts → impossible
                if v != "?" && v != tArr[j] {
                    return ""
                }
                
                // Assign character from t
                ans[i + j] = tArr[j]
            }
        }
        
        // Save a copy BEFORE filling '?' (important for later decisions)
        let old = ans
        
        // STEP 2: Fill remaining '?' with 'a' (default smallest choice)
        for i in 0..<ans.count {
            if ans[i] == "?" {
                ans[i] = "a"
            }
        }
        
        // STEP 3: Handle all 'F' constraints
        // If s[i] == 'F', substring starting at i must NOT equal t
        for i in 0..<n {
            if sArr[i] != "F" { continue }
            
            // Check if substring currently equals t
            var equal = true
            for j in 0..<m {
                if ans[i + j] != tArr[j] {
                    equal = false
                    break
                }
            }
            
            // If already not equal → good, skip
            if !equal { continue }
            
            // Otherwise, we must break equality
            var changed = false
            
            // Try changing from right to left (greedy safe change)
            for j in stride(from: i + m - 1, through: i, by: -1) {
                
                // Only change positions that were originally '?'
                if old[j] == "?" {
                    ans[j] = "b" // change to something different from 'a'
                    changed = true
                    break
                }
            }
            
            // If we couldn't change anything → impossible
            if !changed { return "" }
        }
        
        // Convert result array back to string
        return String(ans)
    }
}