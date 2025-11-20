object Solution {
    def intersectionSizeTwo(intervals: Array[Array[Int]]): Int = {

        // -----------------------------------------------------------
        // STEP 1: Sort intervals
        //  - Primary key: end increasing
        //  - Secondary key: start decreasing (important for greedy correctness)
        // -----------------------------------------------------------
        val sorted = intervals.sortWith { (a, b) =>
            if (a(1) == b(1)) a(0) > b(0)    // start descending
            else a(1) < b(1)                 // end ascending
        }

        // We keep track of the last TWO chosen numbers
        var last = -1     // largest chosen number
        var secondLast = -1   // second largest chosen number

        var result = 0    // total size of the containing set

        // -----------------------------------------------------------
        // STEP 2: Process each interval in greedy order
        // -----------------------------------------------------------
        for (interval <- sorted) {
            val start = interval(0)
            val end   = interval(1)

            // Count how many of our last two selected numbers fall inside [start, end]
            val countInside =
                (if (secondLast >= start) 1 else 0) +
                (if (last >= start) 1 else 0)

            // -----------------------------------------------------------
            // CASE 1: We already have >= 2 numbers inside this interval
            // -----------------------------------------------------------
            if (countInside >= 2) {
                // Nothing to add
            }

            // -----------------------------------------------------------
            // CASE 2: Exactly ONE number is inside interval
            // Add ONE more number = the interval's end
            // -----------------------------------------------------------
            else if (countInside == 1) {
                // shift last into secondLast and add new last = end
                secondLast = last
                last = end
                result += 1
            }

            // -----------------------------------------------------------
            // CASE 3: ZERO numbers inside interval
            // Add TWO numbers: end-1 and end
            // -----------------------------------------------------------
            else {
                // Add the two largest possible points inside interval
                secondLast = end - 1
                last = end
                result += 2
            }
        }

        // final size of containing set
        result
    }
}
