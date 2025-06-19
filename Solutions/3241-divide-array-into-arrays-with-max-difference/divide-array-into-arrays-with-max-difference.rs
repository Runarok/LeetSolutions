impl Solution {
    pub fn divide_array(mut nums: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        // Step 1: Sort the array to make grouping easier.
        nums.sort_unstable(); // Sorting the array in-place for performance.

        // Step 2: Prepare result vector to store valid triplets.
        let mut res = Vec::new(); // Will hold our result triplets.

        // Step 3: Iterate through the sorted nums in chunks of 3.
        let n = nums.len(); // Total number of elements in the input array.

        // Loop through the array, 3 elements at a time
        for i in (0..n).step_by(3) {
            // Step 4: Extract a group of 3 elements.
            let group = &nums[i..i+3]; // Take the 3 consecutive elements.

            // Step 5: Check max and min difference within the triplet.
            let min_val = group[0];   // First element (smallest, due to sorting).
            let mid_val = group[1];   // Second element.
            let max_val = group[2];   // Third element (largest, due to sorting).

            // Step 6: Check if max - min <= k
            if max_val - min_val > k {
                // If not, return an empty vector as per the problem statement.
                return vec![];
            }

            // Step 7: If valid, push this triplet into result.
            res.push(vec![min_val, mid_val, max_val]);
        }

        // Step 8: After successful grouping, return the result.
        res
    }
}
