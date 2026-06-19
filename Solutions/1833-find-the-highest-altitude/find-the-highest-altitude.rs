impl Solution {
    pub fn largest_altitude(gain: Vec<i32>) -> i32 {
        // The biker starts at altitude 0
        let mut current_altitude = 0;

        // Since the starting point is also a valid point,
        // initialize the highest altitude as 0.
        let mut highest_altitude = 0;

        // Go through each altitude gain/loss
        for g in gain {
            // Update the current altitude
            current_altitude += g;

            // If the current altitude is higher than any
            // altitude we've seen before, update the answer.
            if current_altitude > highest_altitude {
                highest_altitude = current_altitude;
            }
        }

        // Return the highest altitude reached during the trip
        highest_altitude
    }
}