object Solution {
    def merge(intervals: Array[Array[Int]]): Array[Array[Int]] = {

        // Edge case: if there are 0 or 1 intervals, nothing to merge
        if (intervals.length <= 1) return intervals

        // Step 1: Sort intervals based on the starting time
        // This ensures that overlapping intervals come next to each other
        val sorted = intervals.sortBy(interval => interval(0))

        // Step 2: Create a list to store merged intervals
        val merged = scala.collection.mutable.ArrayBuffer[Array[Int]]()

        // Step 3: Initialize with the first interval
        var currentStart = sorted(0)(0)
        var currentEnd = sorted(0)(1)

        // Step 4: Iterate through the rest of the intervals
        for (i <- 1 until sorted.length) {

            val start = sorted(i)(0)
            val end = sorted(i)(1)

            // Case 1: Overlapping intervals
            // If the current interval's start is <= currentEnd,
            // it overlaps with the previous one
            if (start <= currentEnd) {
                // Merge by extending the end if needed
                currentEnd = Math.max(currentEnd, end)
            } else {
                // Case 2: No overlap
                // Save the previous interval
                merged += Array(currentStart, currentEnd)

                // Start a new interval
                currentStart = start
                currentEnd = end
            }
        }

        // Step 5: Add the last interval
        merged += Array(currentStart, currentEnd)

        // Convert result to Array[Array[Int]] and return
        merged.toArray
    }
}