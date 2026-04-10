impl Solution {
    pub fn minimum_distance(nums: Vec<i32>) -> i32 {
        // Length of the input array
        let n = nums.len();

        // Create a vector of vectors to store indices for each value
        // Since nums[i] is in range [1, n], we can safely use size n+1
        let mut positions: Vec<Vec<usize>> = vec![Vec::new(); n + 1];

        // Step 1: Group indices by value
        for (i, &num) in nums.iter().enumerate() {
            // Store index i in the list corresponding to value num
            positions[num as usize].push(i);
        }

        // Initialize answer as a large value
        let mut min_distance = i32::MAX;

        // Step 2: Process each value's index list
        for pos_list in positions.iter() {
            // We need at least 3 occurrences to form a good tuple
            if pos_list.len() < 3 {
                continue;
            }

            // Step 3: Try all consecutive triples
            // Why consecutive? Because sorted indices minimize (k - i)
            for i in 0..pos_list.len() - 2 {
                // Pick three indices
                let i_idx = pos_list[i];
                let j_idx = pos_list[i + 1]; // not actually needed for calculation
                let k_idx = pos_list[i + 2];

                // Since i < j < k, distance simplifies to:
                // 2 * (k - i)
                let distance = 2 * (k_idx - i_idx) as i32;

                // Update minimum distance
                min_distance = min_distance.min(distance);
            }
        }

        // If we never updated min_distance, return -1
        if min_distance == i32::MAX {
            -1
        } else {
            min_distance
        }
    }
}