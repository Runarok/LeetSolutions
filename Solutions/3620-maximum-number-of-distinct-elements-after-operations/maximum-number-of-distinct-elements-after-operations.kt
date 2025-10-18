class Solution {
    fun maxDistinctElements(nums: IntArray, k: Int): Int {
        // Step 1: Sort the input array
        nums.sort()

        // Counter for distinct elements
        var count = 0

        // Initialize the previous number used to a very small value
        var prev = Long.MIN_VALUE

        // Iterate through each number in sorted array
        for (num in nums) {
            // Convert num to Long to avoid overflow during calculations
            val numLong = num.toLong()

            // Step 2:
            // Try to assign a value to current number in the range [num - k, num + k]
            // But this value must also be > prev to ensure uniqueness
            // So we take the max of (num - k) and (prev + 1) as the starting point
            // And ensure it's <= num + k

            val lowerBound = numLong - k       // Smallest we can reduce this num to
            val upperBound = numLong + k       // Largest we can increase this num to
            val candidate = maxOf(lowerBound, prev + 1)

            // If candidate is within bounds, we can use it
            if (candidate <= upperBound) {
                count++           // Count this as a new distinct element
                prev = candidate  // Update the last used number
            }

            // If candidate > upperBound, we skip this number
            // because no valid unique number can be formed from it
        }

        // Step 3: Return the total count of distinct elements we managed to create
        return count
    }
}
