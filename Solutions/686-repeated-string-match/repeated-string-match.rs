impl Solution {
    pub fn repeated_string_match(a: String, b: String) -> i32 {
        let mut repeated = String::new();
        let mut count = 0;

        // Keep repeating until the repeated string is at least as long as b
        while repeated.len() < b.len() {
            repeated.push_str(&a);
            count += 1;
        }

        // Check if b is a substring
        if repeated.contains(&b) {
            return count;
        }

        // Sometimes b spans the boundary, add one more repetition
        repeated.push_str(&a);
        count += 1;
        if repeated.contains(&b) {
            return count;
        }

        // Impossible to match
        -1
    }
}
