class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        
        // If lengths differ, they cannot be anagrams
        if s.count != t.count {
            return false
        }
        
        // Frequency array for 26 lowercase letters
        var freq = Array(repeating: 0, count: 26)
        
        // Helper to convert a character to an index (0...25)
        func index(_ c: Character) -> Int {
            return Int(c.asciiValue! - Character("a").asciiValue!)
        }
        
        // Count characters in string s
        for char in s {
            freq[index(char)] += 1
        }
        
        // Subtract counts using string t
        for char in t {
            freq[index(char)] -= 1
            
            // Early exit: if any count goes negative, not an anagram
            if freq[index(char)] < 0 {
                return false
            }
        }
        
        // If all counts are zero, it's an anagram
        return true
    }
}