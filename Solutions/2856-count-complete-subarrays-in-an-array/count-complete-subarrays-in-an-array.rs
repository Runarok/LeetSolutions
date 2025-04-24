use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn count_complete_subarrays(nums: Vec<i32>) -> i32 {
        // 'res' will hold the count of complete subarrays
        let mut res = 0;
        
        // 'cnt' will be a HashMap to track the frequency of elements in the sliding window
        let mut cnt = HashMap::new();
        
        // 'n' is the length of the input array
        let n = nums.len();
        
        // 'right' pointer will represent the end of the current sliding window
        let mut right = 0;
        
        // 'distinct' holds the number of distinct elements in the entire array
        let distinct = nums.iter().collect::<HashSet<_>>().len();
        
        // Iterate with 'left' pointer from 0 to n-1
        for left in 0..n {
            // Step 1: Move the 'left' pointer and remove the element at 'left - 1' from the sliding window
            // If left > 0, we need to shrink the window from the left side by removing the element
            if left > 0 {
                let remove = nums[left - 1];
                
                // Decrease the frequency of the removed element
                *cnt.get_mut(&remove).unwrap() -= 1;
                
                // If the count of that element becomes 0, remove it from the map
                if cnt[&remove] == 0 {
                    cnt.remove(&remove);
                }
            }

            // Step 2: Expand the sliding window by moving the 'right' pointer to the right as long as
            // the number of distinct elements in the current window is less than the total distinct elements
            while right < n && cnt.len() < distinct {
                let add = nums[right];
                
                // Add the element at 'right' to the sliding window and update its count in 'cnt'
                *cnt.entry(add).or_insert(0) += 1;
                
                // Move the 'right' pointer to the next element
                right += 1;
            }

            // Step 3: If the number of distinct elements in the window is equal to the total distinct elements,
            // it means we have found a complete subarray.
            // All subarrays starting from 'left' and ending at any index >= 'right' will be valid.
            if cnt.len() == distinct {
                // We can count all subarrays that start at 'left' and end anywhere from 'right' to the end of the array
                // These subarrays will be complete because they contain all distinct elements
                res += (n - right + 1) as i32;
            }
        }
        
        // Return the total count of complete subarrays
        res
    }
}
