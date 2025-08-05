class Solution {
    fun numOfUnplacedFruits(fruits: IntArray, baskets: IntArray): Int {
        val n = fruits.size

        // Boolean array to track which baskets are already used.
        // Initially, all baskets are unused.
        val used = BooleanArray(n) { false }

        // Counter to track the number of unplaced fruits
        var unplaced = 0

        // Iterate over each fruit from left to right
        for (i in fruits.indices) {
            var placed = false

            // Try to find the first (leftmost) available basket that can hold this fruit
            for (j in baskets.indices) {
                // If the basket is unused and has enough capacity
                if (!used[j] && baskets[j] >= fruits[i]) {
                    used[j] = true   // Mark this basket as used
                    placed = true    // Mark this fruit as placed
                    break            // Stop searching for this fruit
                }
            }

            // If no suitable basket was found, increment the unplaced counter
            if (!placed) {
                unplaced++
            }
        }

        // Return the total number of unplaced fruits
        return unplaced
    }
}
