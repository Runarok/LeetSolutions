class Solution {
    fun numOfUnplacedFruits(fruits: IntArray, baskets: IntArray): Int {
        val n = baskets.size

        // Calculate the size of each block using square root decomposition
        val m = kotlin.math.sqrt(n.toDouble()).toInt()

        // Calculate how many sections we will have
        val section = (n + m - 1) / m

        // Initialize a list to store the maximum value in each section
        val maxV = IntArray(section) { 0 }

        // Fill maxV with the max value of each block
        for (i in 0 until n) {
            val sec = i / m
            maxV[sec] = maxOf(maxV[sec], baskets[i])
        }

        var count = 0 // Counter for unplaced fruits

        // Try placing each fruit
        for (fruit in fruits) {
            var unset = 1 // Assume fruit is unplaced initially

            // Iterate over each section
            for (sec in 0 until section) {
                // Skip if no basket in this section can hold the fruit
                if (maxV[sec] < fruit) continue

                var choose = false // Flag to check if we've placed the fruit

                // Reset max value for this section (we’ll recalculate it)
                maxV[sec] = 0

                // Iterate through the baskets in this section
                for (i in 0 until m) {
                    val pos = sec * m + i
                    if (pos >= n) break // Avoid out-of-bounds

                    if (baskets[pos] >= fruit && !choose) {
                        // Place the fruit in this basket
                        baskets[pos] = 0
                        choose = true
                    }

                    // Update the max for this section
                    maxV[sec] = maxOf(maxV[sec], baskets[pos])
                }

                // If fruit was placed, mark as set and break out of section loop
                if (choose) {
                    unset = 0
                    break
                }
            }

            // If we couldn't place the fruit, increment the counter
            count += unset
        }

        return count
    }
}
