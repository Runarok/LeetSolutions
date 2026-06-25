impl Solution {
    pub fn count_majority_subarrays(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();

        // prefix[i] = transformed sum of nums[0..i)
        let mut prefix = vec![0i32; n + 1];

        // Build prefix sums:
        // target -> +1
        // others -> -1
        for i in 0..n {
            let value = if nums[i] == target { 1 } else { -1 };
            prefix[i + 1] = prefix[i] + value;
        }

        let mut answer: i32 = 0;

        // A subarray [l..r] has transformed sum:
        // prefix[r + 1] - prefix[l]
        //
        // We want this sum > 0:
        // prefix[r + 1] > prefix[l]
        //
        // Count all pairs (l, r+1) satisfying that.
        for l in 0..n {
            for r in (l + 1)..=n {
                if prefix[r] > prefix[l] {
                    answer += 1;
                }
            }
        }

        answer
    }
}