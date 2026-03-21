class Solution {
    func maxPalindromes(_ s: String, _ k: Int) -> Int {
        
        let chars = Array(s)
        let n = chars.count
        
        // dp[i][j] will be true if substring s[i...j] is a palindrome
        var dp = Array(repeating: Array(repeating: false, count: n), count: n)
        
        // Step 1: Fill DP table for palindrome checking
        for length in 1...n {
            for i in 0...(n - length) {
                let j = i + length - 1
                
                if i == j {
                    // Single character is always a palindrome
                    dp[i][j] = true
                } else if chars[i] == chars[j] {
                    
                    if length == 2 {
                        // Two equal characters form a palindrome
                        dp[i][j] = true
                    } else {
                        // Check inner substring
                        dp[i][j] = dp[i + 1][j - 1]
                    }
                }
            }
        }
        
        // Step 2: Collect all valid palindrome substrings of length >= k
        var intervals: [(Int, Int)] = []
        
        for i in 0..<n {
            for j in i..<n {
                
                let length = j - i + 1
                
                // Only consider substrings of length >= k
                if length >= k && dp[i][j] {
                    intervals.append((i, j))
                }
            }
        }
        
        // Step 3: Sort intervals by their ending index
        intervals.sort { $0.1 < $1.1 }
        
        // Greedy selection of non-overlapping intervals
        var count = 0
        var lastEnd = -1
        
        for (start, end) in intervals {
            
            // If this interval does not overlap with the last selected one
            if start > lastEnd {
                count += 1
                lastEnd = end
            }
        }
        
        return count
    }
}