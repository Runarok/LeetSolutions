use std::collections::HashMap;

impl Solution {
    pub fn count_interesting_subarrays(nums: Vec<i32>, modulo: i32, k: i32) -> i64 {
        let n = nums.len();  // Get the length of the input array
        let mut cnt: HashMap<i32, i32> = HashMap::new();  // HashMap to store the frequency of prefix sums modulo `modulo`
        let mut res: i64 = 0;  // This will store the result: count of interesting subarrays
        let mut prefix: i32 = 0;  // This keeps track of how many elements in the array satisfy `nums[i] % modulo == k`

        // Initialize the HashMap with entry for prefix sum modulo 0 (since there can be subarrays starting at index 0).
        *cnt.entry(0).or_insert(0) += 1;

        // Iterate through the elements of the array.
        for i in 0..n {
            // If the current number satisfies `nums[i] % modulo == k`, increment the `prefix` counter.
            if nums[i] % modulo == k {
                prefix += 1;
            }

            // Now, we need to find how many previous prefix sums modulo `modulo` satisfy the condition
            // that the current subarray is "interesting".
            // The condition for the subarray nums[l..r] being interesting is:
            //    (prefix - k) % modulo == some previously seen prefix sum % modulo
            //    Hence, we are looking for prefix sums that satisfy:
            //    (prefix - k + modulo) % modulo
            res += *cnt.get(&((prefix - k + modulo) % modulo)).unwrap_or(&0) as i64;

            // Now update the HashMap with the current prefix modulo value.
            // We increment the count of the current prefix sum modulo value in `cnt`.
            *cnt.entry(prefix % modulo).or_insert(0) += 1;
        }

        // Return the result, which is the count of interesting subarrays.
        res
    }
}
