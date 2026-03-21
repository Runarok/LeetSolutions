impl Solution {
    pub fn generate_parenthesis(n: i32) -> Vec<String> {
        
        let mut result = Vec::new();

        // Helper backtracking function
        fn backtrack(
            current: String,
            open: i32,
            close: i32,
            max: i32,
            result: &mut Vec<String>,
        ) {
            // Base case: if string length is 2 * n
            if current.len() == (max * 2) as usize {
                result.push(current);
                return;
            }

            // Option 1: Add '(' if we still have some left
            if open < max {
                backtrack(
                    format!("{}(", current), // add '('
                    open + 1,
                    close,
                    max,
                    result,
                );
            }

            // Option 2: Add ')' if valid
            // Only if we have more '(' than ')'
            if close < open {
                backtrack(
                    format!("{})", current), // add ')'
                    open,
                    close + 1,
                    max,
                    result,
                );
            }
        }

        // Start recursion
        backtrack(String::new(), 0, 0, n, &mut result);

        result
    }
}