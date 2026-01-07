class Solution {

    func largestAltitude(_ gain: [Int]) -> Int {

        // Step 1: Initialize the current altitude
        // The biker starts at altitude 0
        var currentAltitude = 0

        // Step 2: Initialize the maximum altitude found so far
        // Initially, it's the starting altitude
        var maxAltitude = 0

        // Step 3: Loop through each net gain in the gain array
        for delta in gain {

            // Update the current altitude after this segment
            currentAltitude += delta

            // Update the maximum altitude if current is higher
            if currentAltitude > maxAltitude {
                maxAltitude = currentAltitude
            }
        }

        // Step 4: Return the highest altitude reached
        return maxAltitude
    }
}
