impl Solution {
    pub fn process_str(s: String) -> String {
        // This string will store the current result while we process
        // the input from left to right.
        let mut result = String::new();

        // Iterate through every character in the input string.
        for ch in s.chars() {
            match ch {
                // If the character is a lowercase letter,
                // append it to the result.
                'a'..='z' => {
                    result.push(ch);
                }

                // '*' removes the last character from result
                // if there is one.
                '*' => {
                    result.pop();
                }

                // '#' duplicates the current result and appends
                // it to itself.
                //
                // Example:
                // result = "abc"
                // copy   = "abc"
                // result becomes "abcabc"
                '#' => {
                    let copy = result.clone();
                    result.push_str(&copy);
                }

                // '%' reverses the current result.
                //
                // Example:
                // result = "abcd"
                // becomes "dcba"
                '%' => {
                    result = result.chars().rev().collect();
                }

                // Not needed for this problem because the input
                // only contains lowercase letters, '*', '#', '%'.
                _ => {}
            }
        }

        // After processing all characters, return the final result.
        result
    }
}