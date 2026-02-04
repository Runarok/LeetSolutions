impl Solution {
    pub fn max_sum_trionic(nums: Vec<i32>) -> i64 {
        // Number of elements in the array
        let n = nums.len();

        // Represents how the array changes between two adjacent elements
        // Decreasing: nums[i+1] < nums[i]
        // Zero:       nums[i+1] == nums[i]
        // Increasing: nums[i+1] > nums[i]
        #[derive(Debug, PartialEq, Clone, Copy)]
        enum Slope {
            Decreasing,
            Zero,
            Increasing
        };

        // Represents a maximal contiguous interval
        // where the slope is constant
        #[derive(Debug, Clone, Copy)]
        struct Interval {
            start: usize,  // inclusive
            end: usize,    // inclusive
            slope: Slope
        };

        // Helper function: determine the slope between two values
        fn get_slope(a: i32, b: i32) -> Slope {
            match b - a {
                dec if dec < 0 => Slope::Decreasing,
                0 => Slope::Zero,
                _ => Slope::Increasing
            }
        };

        // Prefix sum array:
        // prefix[i] = sum of nums[0..i)
        let mut prefix: Vec<i64> = Vec::with_capacity(n + 1);
        prefix.push(0);                     // sum of empty prefix
        prefix.push(nums[0] as i64);        // nums[0]
        prefix.push((nums[0] + nums[1]) as i64); // nums[0] + nums[1]

        // Split the array into slope-constant intervals
        let mut intervals: Vec<Interval> = Vec::new();

        // Start with the slope between nums[0] and nums[1]
        let mut part = Interval {
            start: 0,
            end: 1,
            slope: get_slope(nums[0], nums[1])
        };

        // Iterate through the array to build intervals
        for i in 2..nums.len() {
            // Extend prefix sum
            prefix.push(prefix.last().unwrap() + nums[i] as i64);

            // Slope between nums[i-1] and nums[i]
            let m_right = get_slope(nums[i - 1], nums[i]);

            // If slope changes, close current interval
            if m_right != part.slope {
                part.end = i - 1;
                intervals.push(part);

                // Start a new interval
                part = Interval {
                    start: i - 1,
                    end: i,
                    slope: m_right
                };
            }
        }

        // Push the final interval
        part.end = nums.len() - 1;
        intervals.push(part);

        // Result: maximum trionic subarray sum found
        let mut res = i64::MIN;

        // Look at every consecutive triple of intervals
        for window in intervals.windows(3) {
            let (a, b, c) = (window[0], window[1], window[2]);

            // We only care about:
            // Increasing -> Decreasing -> Increasing
            if a.slope != Slope::Increasing ||
               b.slope != Slope::Decreasing ||
               c.slope != Slope::Increasing {
                continue;
            }

            // Find best starting point in the left increasing interval
            // We maximize sum over [i .. a.end]
            let (mut sum, mut begin) = (i64::MIN, a.start);
            for i in a.start..a.end {
                let window_sum = prefix[a.end + 1] - prefix[i];
                if window_sum > sum {
                    sum = window_sum;
                    begin = i;
                }
            }

            // Find best ending point in the right increasing interval
            // We maximize sum over [c.start .. i]
            let (mut sum, mut end) = (i64::MIN, c.start);
            for i in (c.start + 1)..=c.end {
                let window_sum = prefix[i + 1] - prefix[c.start];
                if window_sum > sum {
                    sum = window_sum;
                    end = i;
                }
            }

            // Combine the best left start and right end
            // Full trionic subarray is [begin .. end]
            res = res.max(prefix[end + 1] - prefix[begin]);
        }

        res
    }
}
