use std::cmp::{min, max};

impl Solution {
    // Function to find the maximum Manhattan distance after performing at most k modifications
    // on directions represented by the string `s`.
    pub fn max_distance(s: String, k: i32) -> i32 {
        // Initialize the answer to zero
        let mut ans = 0;

        // Counters for each direction encountered so far
        let (mut north, mut south, mut east, mut west) = (0, 0, 0, 0);

        // Iterate over each character (direction) in the input string
        for c in s.chars() {
            // Update the respective counters based on the current character
            match c {
                'N' => north += 1,  // Move north counter up by one
                'S' => south += 1,  // Move south counter up by one
                'E' => east += 1,   // Move east counter up by one
                'W' => west += 1,   // Move west counter up by one
                _ => (),            // Ignore any other characters (if any)
            }

            // Calculate how many modifications we can use to balance north/south directions:
            // We want to reduce the smaller count between north and south by "modifying" some steps
            // But the maximum modifications allowed here is at most k.
            let times1 = min(min(north, south), k);

            // Calculate how many modifications we can use to balance east/west directions:
            // We can only use the remaining modifications after using times1 modifications.
            let times2 = min(min(east, west), k - times1);

            // Calculate the current modified Manhattan distance:
            // 1. Calculate difference between north and south after applying modifications times1.
            // 2. Calculate difference between east and west after applying modifications times2.
            // 3. Sum both results.
            let current = Self::count(north, south, times1) + Self::count(east, west, times2);

            // Update the maximum answer found so far if current distance is larger
            ans = max(ans, current);
        }

        // Return the maximum Manhattan distance achievable with at most k modifications
        ans
    }

    // Helper function to calculate the modified Manhattan distance for one axis
    // drt1 and drt2 are counts of two opposite directions (e.g., north and south)
    // times is the number of allowed modifications that can flip one direction into the other
    //
    // For example, if north=5, south=3, and times=2,
    // the distance would be |5 - 3| + 2 * 2 = 2 + 4 = 6
    // because we can use 2 modifications to further increase the distance by 2 each
    fn count(drt1: i32, drt2: i32, times: i32) -> i32 {
        // Absolute difference between counts of the two directions
        // plus twice the number of modifications (each modification adds 2 to the difference)
        (drt1 - drt2).abs() + times * 2
    }
}
