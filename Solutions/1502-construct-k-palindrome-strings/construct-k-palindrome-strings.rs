use std::collections::HashMap;

impl Solution {
    pub fn can_construct(s: String, k: i32) -> bool {
        let mut freq = HashMap::new();
        
        // Count the frequency of each character
        for ch in s.chars() {
            *freq.entry(ch).or_insert(0) += 1;
        }
        
        // Count how many characters have an odd frequency
        let odd_count = freq.values().filter(|&&count| count % 2 != 0).count();
        
        // Check if we can create k palindromic substrings
        // We need at least `odd_count` palindromes to accommodate all odd counts
        // Also, k should not be more than the length of the string
        k as usize >= odd_count && k as usize <= s.len()
    }
}
