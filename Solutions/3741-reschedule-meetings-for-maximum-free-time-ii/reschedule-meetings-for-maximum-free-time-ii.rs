impl Solution {
    pub fn max_free_time(event_time: i32, start_time: Vec<i32>, end_time: Vec<i32>) -> i32 {
        let n = start_time.len();
        
        // Boolean vector to mark which intervals are fully overlappable (can be skipped)
        let mut q = vec![false; n];

        let mut t1 = 0; // max free time from the left
        let mut t2 = 0; // max free time from the right

        // Forward and backward pass to check if the current event duration can be skipped
        for i in 0..n {
            // Forward pass
            // If the duration of current event is less than or equal to max free time so far
            if end_time[i] - start_time[i] <= t1 {
                q[i] = true; // mark this event as skippable
            }
            // Update t1 with maximum gap between current start and previous end
            t1 = t1.max(start_time[i] - if i == 0 { 0 } else { end_time[i - 1] });

            // Backward pass (mirror of forward)
            let j = n - i - 1;
            if end_time[j] - start_time[j] <= t2 {
                q[j] = true; // mark this event as skippable
            }
            // Update t2 with max gap between next start and current end (in reverse)
            t2 = t2.max(if i == 0 { event_time } else { start_time[n - i] } - end_time[j]);
        }

        let mut res = 0; // Result to store maximum free time

        // Iterate through events to compute max free time
        for i in 0..n {
            // Calculate time window between current and adjacent events
            let left = if i == 0 { 0 } else { end_time[i - 1] };
            let right = if i == n - 1 { event_time } else { start_time[i + 1] };

            if q[i] {
                // If event is skippable, full gap between neighbors is free time
                res = res.max(right - left);
            } else {
                // Otherwise, reduce the duration of current event from the free window
                res = res.max(right - left - (end_time[i] - start_time[i]));
            }
        }

        res
    }
}
