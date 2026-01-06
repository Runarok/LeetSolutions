class Solution {
    func repeatedSubstringPattern(_ s: String) -> Bool {
        // -----------------------------------------
        // Step 1: Get length of string
        // -----------------------------------------
        let n = s.count
        if n <= 1 { return false } // strings of length 1 cannot repeat
        
        // -----------------------------------------
        // Step 2: Convert string to array of characters
        // -----------------------------------------
        let chars = Array(s)
        
        // -----------------------------------------
        // Step 3: Try all possible substring lengths
        // Only lengths that divide n are valid
        // -----------------------------------------
        for len in 1...(n / 2) {
            if n % len != 0 { continue } // substring length must divide n
            
            // -----------------------------------------
            // Step 3a: Safely create candidate substring
            // -----------------------------------------
            let safeEnd = min(len, chars.count) // avoid out-of-bounds
            let sub = String(chars[0..<safeEnd])
            
            // -----------------------------------------
            // Step 3b: Build string by repeating substring
            // -----------------------------------------
            let repeatCount = n / len
            var built = ""
            for _ in 0..<repeatCount {
                built += sub
            }
            
            // -----------------------------------------
            // Step 3c: Check if built string equals original
            // -----------------------------------------
            if built == s {
                return true
            }
        }
        
        // -----------------------------------------
        // Step 4: No valid repeating substring found
        // -----------------------------------------
        return false
    }
}
