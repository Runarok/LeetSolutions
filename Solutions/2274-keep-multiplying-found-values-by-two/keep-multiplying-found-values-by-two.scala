object Solution {
    def findFinalValue(nums: Array[Int], original: Int): Int = {

        // Convert nums to a Set for O(1) lookup instead of O(n) list search.
        // This improves efficiency especially when nums is large.
        val numSet = nums.toSet

        // We'll use a variable to track the current `original` value
        var current = original

        // Keep doubling `current` as long as it exists in the set
        while (numSet.contains(current)) {
            // If found, multiply by 2
            current = current * 2
        }

        // Once we reach a number not found in the array, return it
        current
    }
}
