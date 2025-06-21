use std::collections::HashMap;

impl Solution {
    pub fn minimum_deletions(word: String, k: i32) -> i32 {
        // Step 1: Count the frequency of each character in the string
        let mut cnt = HashMap::new();
        for c in word.chars() {
            *cnt.entry(c).or_insert(0) += 1;
        }

        // Initialize result with maximum possible deletions: deleting all characters
        let mut res = word.len() as i32;

        // Iterate over each unique frequency `a` from the frequency map
        for &a in cnt.values() {
            // This variable will store the total number of deletions needed
            // to make all character frequencies within `k` of `a`
            let mut deleted = 0;

            // Compare `a` to all other frequencies `b` in the map
            for &b in cnt.values() {
                if a > b {
                    // Case 1: If `b` is less than `a`, and thus within `k`, 
                    // we might still delete all of `b` if needed to match the range
                    deleted += b;
                } else if b > a + k {
                    // Case 2: If `b` is more than `a + k`, we must reduce `b` to `a + k`
                    deleted += b - (a + k);
                }
                // Else, if `b` in [a, a+k], it’s fine, no deletion needed
            }

            // Update the result with the minimum deletions found so far
            res = res.min(deleted);
        }

        res
    }
}
