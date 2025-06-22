impl Solution {
    /// Divides the input string `s` into groups of length `k`.
    /// If the last group is shorter than `k`, it is filled with the `fill` character.
    pub fn divide_string(s: String, k: i32, fill: char) -> Vec<String> {
        let mut res = Vec::new(); // Vector to store the resulting groups of strings
        let n = s.len(); // Total length of the input string
        let mut curr = 0; // Current index to keep track of where the group starts

        // Split the string into chunks of size `k`
        while curr < n {
            // Calculate the end index for the current chunk, ensuring we don't exceed string length
            let end = (curr + k as usize).min(n);
            
            // Push the substring from curr to end as a new group into the result vector
            res.push(s[curr..end].to_string());

            // Move to the start of the next group
            curr += k as usize;
        }

        // Check the last group and fill it with the `fill` character if it's shorter than `k`
        if let Some(last) = res.last_mut() {
            if last.len() < k as usize {
                // Calculate how many characters are missing and append that many `fill` characters
                *last += &fill.to_string().repeat(k as usize - last.len());
            }
        }

        // Return the vector containing all the divided and padded string groups
        res
    }
}
