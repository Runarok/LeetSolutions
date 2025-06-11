impl Solution {
    pub fn max_difference(s: String, k: i32) -> i32 {
        // Length of the input string
        let n = s.len();
        
        // Initialize answer to smallest possible i32 value
        // so any valid result will be greater than this
        let mut ans = i32::MIN;
        
        // Convert the input string into a vector of chars for easy indexing
        let chars: Vec<char> = s.chars().collect();
        
        // A helper function to encode the parity (odd/even) status of frequencies
        // cnt_a and cnt_b are counts of characters 'a' and 'b' respectively
        // Returns an integer 0-3 representing:
        // bit 1 (left): parity of cnt_a (1 if odd, 0 if even)
        // bit 0 (right): parity of cnt_b (1 if odd, 0 if even)
        fn get_status(cnt_a: i32, cnt_b: i32) -> i32 {
            ((cnt_a & 1) << 1) | (cnt_b & 1)
        }
        
        // We iterate over all possible pairs of distinct characters (a, b)
        // The problem states digits from '0' to '4' only, but original code had '5' as well (extra)
        // We'll limit to '0' to '4' as per problem statement
        for &a in &['0', '1', '2', '3', '4'] {
            for &b in &['0', '1', '2', '3', '4'] {
                // Skip if characters are the same, as a != b required
                if a == b {
                    continue;
                }
                
                // Initialize an array best of size 4 to store minimum differences for each parity state
                // best[i] represents the minimum value of (prev_a - prev_b) encountered for parity state i
                let mut best = [i32::MAX; 4];
                
                // Initialize counts of characters a and b in current window and prefix sums
                let (mut cnt_a, mut cnt_b) = (0, 0);
                let (mut prev_a, mut prev_b) = (0, 0);
                
                // Left pointer initialized to -1 (meaning window initially empty)
                let mut left = -1;
                
                // Iterate over the string with right pointer expanding the window
                for right in 0..n {
                    // Increase count if current character is 'a'
                    cnt_a += if chars[right] == a { 1 } else { 0 };
                    // Increase count if current character is 'b'
                    cnt_b += if chars[right] == b { 1 } else { 0 };
                    
                    // While the current window length is at least k and
                    // frequency difference of b in prefix is >= 2 (this is a heuristic to move left)
                    while (right as i32 - left) >= k && (cnt_b - prev_b) >= 2 {
                        // Calculate the parity status of the prefix counts
                        let left_status = get_status(prev_a, prev_b) as usize;
                        
                        // Update the best minimum (prev_a - prev_b) for this parity status
                        best[left_status] = best[left_status].min(prev_a - prev_b);
                        
                        // Move left pointer forward to shrink window
                        left += 1;
                        
                        // Update prefix counts by removing character at new left pointer
                        prev_a += if chars[left as usize] == a { 1 } else { 0 };
                        prev_b += if chars[left as usize] == b { 1 } else { 0 };
                    }
                    
                    // Get the parity status for current counts
                    let right_status = get_status(cnt_a, cnt_b) as usize;
                    
                    // Check if the opposite parity state for character a is recorded in best[]
                    // We want to match substrings with opposite parity of 'a' (flip bit 1)
                    // XOR with 0b10 flips the parity of cnt_a (odd/even)
                    if best[right_status ^ 0b10] != i32::MAX {
                        // Calculate difference using prefix sums technique and update ans
                        // This ensures that substrings counted satisfy parity requirements
                        ans = ans.max(cnt_a - cnt_b - best[right_status ^ 0b10]);
                    }
                }
            }
        }
        
        // Return answer or -1 if no valid substring found (ans was never updated)
        if ans == i32::MIN {
            -1
        } else {
            ans
        }
    }
}
