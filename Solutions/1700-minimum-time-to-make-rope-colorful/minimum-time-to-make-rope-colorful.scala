object Solution {
    def minCost(colors: String, neededTime: Array[Int]): Int = {
        // -------------------------------
        // Step 1: Initialize variables
        // -------------------------------
        // 'totalTime' will store the total minimum time required
        var totalTime = 0
        
        // We'll iterate through the colors string, comparing each balloon
        // with the previous one to detect consecutive duplicates.
        
        // -------------------------------
        // Step 2: Loop through all balloons
        // -------------------------------
        for (i <- 1 until colors.length) {
            // Check if the current balloon has the same color as the previous one
            if (colors(i) == colors(i - 1)) {
                
                // If yes, we have a conflict (two consecutive same colors)
                // One balloon must be removed
                
                // We will remove the one that takes LESS time to remove
                // (i.e., keep the one with higher neededTime)
                
                // Add the smaller of the two removal times to totalTime
                totalTime += Math.min(neededTime(i), neededTime(i - 1))
                
                // Now we must "update" the neededTime of the current balloon
                // to be the max of the two — because we conceptually "keep"
                // the balloon with higher removal time.
                // This ensures future comparisons use the correct "kept" balloon.
                neededTime(i) = Math.max(neededTime(i), neededTime(i - 1))
            }
        }
        
        // -------------------------------
        // Step 3: Return result
        // -------------------------------
        // After we finish processing all balloons, totalTime holds
        // the minimum total time needed to make the rope colorful.
        totalTime
    }
}
