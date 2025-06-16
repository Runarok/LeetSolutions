impl Solution {
    pub fn maximum_difference(nums: Vec<i32>) -> i32 {
        // Initialize min_val with the first element of the array.
        // This keeps track of the smallest number found so far.
        let mut min_val = nums[0];
        
        // Initialize max_diff with -1.
        // This will store the maximum difference found that satisfies conditions.
        // If no such difference is found, -1 will be returned.
        let mut max_diff = -1;

        // Start iterating from the second element (index 1) since min_val is the first element.
        // We use `nums.iter().skip(1)` to get an iterator skipping the first element.
        for &num in nums.iter().skip(1) {
            // Check if the current number `num` is greater than the minimum value found so far.
            // This condition ensures that nums[i] < nums[j] and i < j, because min_val
            // was from an earlier index, and `num` is the current number at a later index.
            if num > min_val {
                // Calculate the difference between current number and min_val.
                let diff = num - min_val;
                
                // Update max_diff if the newly calculated difference is larger.
                // max_diff.max(diff) returns the greater of the two values.
                max_diff = max_diff.max(diff);
            } else {
                // If current number is smaller or equal to min_val,
                // update min_val to the current number.
                // This helps in finding the smallest number for future comparisons.
                min_val = num;
            }
        }

        // Return the maximum difference found.
        // If no valid pair (i, j) satisfying the conditions was found,
        // max_diff remains -1 as initialized.
        max_diff
    }
}
