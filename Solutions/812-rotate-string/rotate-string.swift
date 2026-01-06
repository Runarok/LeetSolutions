class Solution {
    func rotateString(_ s: String, _ goal: String) -> Bool {
        // Step 1: If lengths are different, return false
        if s.count != goal.count {
            return false
        }
        
        // Step 2: Concatenate s with itself
        let doubleS = s + s
        
        // Step 3: Check if goal is a substring of doubleS
        return doubleS.contains(goal)
    }
}

