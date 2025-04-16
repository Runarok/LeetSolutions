use std::collections::HashMap;

impl Solution {
    pub fn count_good(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut freq_map = HashMap::new(); // Frequency map for elements in the current window
        let mut count_pairs = 0; // Total number of pairs in the current window
        let mut left = 0; // Left pointer of the sliding window
        let mut result = 0; // This will store the number of good subarrays
        
        // Helper function to calculate number of pairs from the count of a number
        fn num_pairs(count: i32) -> i32 {
            if count < 2 { return 0; }
            count * (count - 1) / 2
        }

        for right in 0..n {
            let num = nums[right];
            let current_count = freq_map.entry(num).or_insert(0);
            let prev_count = *current_count;

            // Before adding the current number to the window, remove the old pairs count
            count_pairs -= num_pairs(prev_count);

            // Update frequency map and count new pairs
            *current_count += 1;
            count_pairs += num_pairs(*current_count);

            // Shrink the window from the left as long as we have at least k pairs
            while count_pairs >= k {
                // All subarrays starting from left to right are valid
                result += (n - right) as i64;

                // Remove the element at left and update pair count
                let num_left = nums[left];
                let left_count = freq_map.entry(num_left).or_insert(0);
                count_pairs -= num_pairs(*left_count);
                *left_count -= 1;
                count_pairs += num_pairs(*left_count);

                // Move the left pointer to shrink the window
                left += 1;
            }
        }

        result
    }
}
