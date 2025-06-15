impl Solution {
    /// Returns the maximum difference between two numbers obtained by
    /// replacing all occurrences of a single digit in `num` with another digit.
    ///
    /// # Arguments
    ///
    /// * `num` - The original number to transform.
    ///
    /// # Returns
    ///
    /// The maximum difference possible by digit replacement.
    pub fn max_diff(num: i32) -> i32 {
        // Helper function:
        // Replaces all occurrences of digit `from` with digit `to` in `num`.
        // Returns `None` if the resulting number has a leading zero (invalid).
        fn replace_digits(num: i32, from: char, to: char) -> Option<i32> {
            let s = num.to_string();
            // Map each character: if it matches `from`, replace with `to`.
            let replaced: String = s
                .chars()
                .map(|c| if c == from { to } else { c })
                .collect();

            // Check for leading zero after replacement.
            if replaced.starts_with('0') {
                return None; // Invalid number
            }

            // Parse replaced string back to i32 safely.
            replaced.parse().ok()
        }

        let num_str = num.to_string();
        let digits: Vec<char> = num_str.chars().collect();

        let mut min_num = num;
        let mut max_num = num;

        // Iterate over all digits present in the number (optimization).
        for &x in digits.iter() {
            // Try replacing digit x with every digit y from '0' to '9'.
            for y in '0'..='9' {
                // Skip replacement if it wouldn't change anything.
                if x == y {
                    continue;
                }

                // Attempt the replacement.
                if let Some(candidate) = replace_digits(num, x, y) {
                    // Update min and max results.
                    if candidate < min_num {
                        min_num = candidate;
                    }
                    if candidate > max_num {
                        max_num = candidate;
                    }
                }
            }
        }

        // Return the difference between max and min found.
        max_num - min_num
    }
}
