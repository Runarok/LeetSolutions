impl Solution {
    pub fn max_adjacent_distance(nums: Vec<i32>) -> i32 {
        // Get the length of the array
        let n = nums.len();
        
        // Initialize max_diff to 0 to keep track of the maximum absolute difference found
        let mut max_diff = 0;
        
        // Iterate through each index in the array
        for i in 0..n {
            // Calculate the next index in circular manner
            // When i is the last index, next wraps back to 0
            let next = (i + 1) % n;
            
            // Calculate the absolute difference between the current element and the next element
            let diff = (nums[i] - nums[next]).abs();
            
            // Update max_diff if the current difference is greater than the recorded maximum
            if diff > max_diff {
                max_diff = diff;
            }
        }
        
        // Return the maximum absolute difference found
        max_diff
    }
}
