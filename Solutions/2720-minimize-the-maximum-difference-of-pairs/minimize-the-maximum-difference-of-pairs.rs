impl Solution {
    pub fn minimize_max(mut nums: Vec<i32>, p: i32) -> i32 {
        // Edge case: if p == 0, no pairs needed, max difference is 0
        if p == 0 {
            return 0;
        }

        // Sort nums to consider adjacent pairs easily
        nums.sort();

        // Binary search boundaries for answer (max difference)
        // min_diff can be 0, max_diff can be max(nums) - min(nums)
        let mut left = 0;
        let mut right = nums[nums.len() - 1] - nums[0];

        // Helper closure to check if we can form at least p pairs
        // with max difference <= mid
        let can_form = |mid: i32| -> bool {
            let mut count = 0;  // number of pairs formed
            let mut i = 0;

            // Iterate through nums greedily pairing elements
            while i < nums.len() - 1 {
                // If adjacent difference is <= mid, form a pair and skip both indices
                if nums[i + 1] - nums[i] <= mid {
                    count += 1;
                    i += 2;  // skip paired indices
                } else {
                    i += 1;  // move forward to check next possible pair
                }

                // If we already formed enough pairs, return true early
                if count >= p {
                    return true;
                }
            }

            // If formed pairs less than p, return false
            count >= p
        };

        // Binary search for minimum maximum difference
        while left < right {
            let mid = left + (right - left) / 2;

            if can_form(mid) {
                right = mid;  // try smaller max difference
            } else {
                left = mid + 1;  // need bigger max difference
            }
        }

        // Left is the minimum maximum difference after binary search ends
        left
    }
}
