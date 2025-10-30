object Solution {
    def minNumberOperations(target: Array[Int]): Int = {
        // Edge case: if the array is empty, no operations are needed
        if (target.isEmpty) return 0

        // Initialize the answer with target[0]
        // Because to get from [0, 0, 0, ...] to at least [target[0], ...],
        // we must perform target[0] operations on the first subarray.
        var ans = target(0)

        // Traverse from the second element onwards
        for (i <- 1 until target.length) {
            // Compute the difference between adjacent elements
            val diff = target(i) - target(i - 1)

            // If diff > 0, it means target[i] requires additional (diff) operations
            // beyond what was needed for target[i-1].
            if (diff > 0)
                ans += diff
        }

        // Return the total minimal operations
        ans
    }
}
