impl Solution {
    pub fn maximize_square_hole_area(
        n: i32,
        m: i32,
        h_bars: Vec<i32>,
        v_bars: Vec<i32>,
    ) -> i32 {

        // ------------------------------------------------------------
        // Helper function:
        // Given a list of removable bars (already sorted),
        // find the maximum number of *consecutive* bars.
        //
        // Example:
        //   [2, 3, 4] -> 3 consecutive bars -> hole size = 4
        //   [2, 4, 6] -> max consecutive = 1 -> hole size = 2
        // ------------------------------------------------------------
        fn max_consecutive(bars: &Vec<i32>) -> i32 {
            // If there are no removable bars,
            // the biggest hole possible is just 1 unit
            if bars.is_empty() {
                return 1;
            }

            // Track the longest run found so far
            let mut max_run = 1;

            // Track the length of the current consecutive run
            let mut current_run = 1;

            // Walk through the bars and check adjacency
            for i in 1..bars.len() {
                // If bars differ by exactly 1,
                // they are consecutive
                if bars[i] == bars[i - 1] + 1 {
                    current_run += 1;
                } else {
                    // Break in sequence → reset run counter
                    current_run = 1;
                }

                // Update the maximum run length seen
                max_run = max_run.max(current_run);
            }

            // If we remove k consecutive bars,
            // we create a hole of size (k + 1)
            max_run + 1
        }

        // ------------------------------------------------------------
        // Step 1: Sort the removable bars
        // ------------------------------------------------------------
        let mut h = h_bars.clone();
        let mut v = v_bars.clone();

        h.sort();
        v.sort();

        // ------------------------------------------------------------
        // Step 2: Compute max hole size in each direction
        // ------------------------------------------------------------
        let max_hole_height = max_consecutive(&h);
        let max_hole_width  = max_consecutive(&v);

        // ------------------------------------------------------------
        // Step 3: The square side is limited by the smaller dimension
        // ------------------------------------------------------------
        let side = max_hole_height.min(max_hole_width);

        // ------------------------------------------------------------
        // Step 4: Return square area
        // ------------------------------------------------------------
        side * side
    }
}
