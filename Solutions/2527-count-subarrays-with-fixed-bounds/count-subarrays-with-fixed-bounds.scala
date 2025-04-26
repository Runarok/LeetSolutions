object Solution {
    def countSubarrays(nums: Array[Int], minK: Int, maxK: Int): Long = {
        var count: Long = 0  // This will hold the final count of valid subarrays
        val n: Int = nums.length  // Length of the input array
        var minKIndex: Int = -1  // Last index where minK was encountered
        var maxKIndex: Int = -1  // Last index where maxK was encountered
        var leftBound: Int = -1  // Last index where an invalid number (out of bounds) was encountered

        // Iterate through the array
        for (i <- nums.indices) {
            // If the current number is out of the valid range [minK, maxK], reset the window
            if (nums(i) < minK || nums(i) > maxK) {
                leftBound = i  // Reset left boundary
                minKIndex = -1  // Reset minK index
                maxKIndex = -1  // Reset maxK index
            } else {
                // If the current number is equal to minK, update minKIndex
                if (nums(i) == minK) {
                    minKIndex = i
                }

                // If the current number is equal to maxK, update maxKIndex
                if (nums(i) == maxK) {
                    maxKIndex = i
                }

                // If both minK and maxK have been encountered at least once
                if (minKIndex != -1 && maxKIndex != -1) {
                    // Add to the count the number of valid subarrays that end at the current position i
                    // Valid subarrays are formed from positions between leftBound and the minimum of minKIndex and maxKIndex
                    count += math.min(minKIndex, maxKIndex) - leftBound
                }
            }
        }
        
        count  // Return the total count of valid subarrays
    }
}
