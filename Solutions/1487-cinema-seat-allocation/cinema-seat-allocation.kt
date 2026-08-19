class Solution {
    fun maxNumberOfFamilies(
        n: Int,
        reservedSeats: Array<IntArray>
    ): Int {

        // Each completely empty row can always accommodate 2 groups:
        //
        //     [2,3,4,5]   [6,7,8,9]
        //
        // So initially assume every row has 2 groups.
        var answer = n.toLong() * 2

        /*
         * Store the reserved seats for each row as a bitmask.
         *
         * Bit 0 -> seat 1
         * Bit 1 -> seat 2
         * ...
         * Bit 9 -> seat 10
         *
         * For example, if seats 2 and 5 are reserved:
         *
         * seat:  1 2 3 4 5 6 7 8 9 10
         *        0 1 0 0 1 0 0 0 0 0
         *
         * We only need to process rows that actually have
         * reserved seats. Since n can be as large as 10^9,
         * we cannot iterate through every row.
         */
        val reserved = HashMap<Int, Int>()

        for (seat in reservedSeats) {
            val row = seat[0]
            val column = seat[1]

            // Convert the seat number (1..10) into a bit position (0..9).
            val bit = 1 shl (column - 1)

            // Add this reserved seat to the row's bitmask.
            reserved[row] = (reserved[row] ?: 0) or bit
        }

        /*
         * Masks for the three possible group positions.
         *
         * Left:
         * seats 2,3,4,5
         *
         * Middle:
         * seats 4,5,6,7
         *
         * Right:
         * seats 6,7,8,9
         */

        val left =
            (1 shl 1) or
            (1 shl 2) or
            (1 shl 3) or
            (1 shl 4)

        val middle =
            (1 shl 3) or
            (1 shl 4) or
            (1 shl 5) or
            (1 shl 6)

        val right =
            (1 shl 5) or
            (1 shl 6) or
            (1 shl 7) or
            (1 shl 8)

        /*
         * Process only rows containing reservations.
         */
        for ((_, mask) in reserved) {

            // Check whether each possible block is completely free.
            val canLeft = (mask and left) == 0
            val canMiddle = (mask and middle) == 0
            val canRight = (mask and right) == 0

            /*
             * There are only a few possibilities.
             *
             * 1. Left AND right are available.
             *
             *    [2 3 4 5] [6 7 8 9]
             *
             *    These two groups don't overlap, so we can
             *    place 2 groups.
             */
            if (canLeft && canRight) {
                // We already counted 2 groups for this row.
                // Nothing needs to be changed.
            }

            /*
             * 2. At least one of the three blocks is available.
             *
             *    We can place exactly 1 group.
             *
             *    This includes:
             *      - only left
             *      - only middle
             *      - only right
             *      - left + middle
             *      - middle + right
             *
             *    In all these cases, only 1 group can be placed
             *    because the available blocks overlap.
             */
            else if (canLeft || canMiddle || canRight) {
                // We initially counted 2.
                // This row can actually fit only 1.
                answer -= 1
            }

            /*
             * 3. None of the three blocks is available.
             *
             *    Therefore this row can fit 0 groups.
             *
             *    We initially counted 2, so remove both.
             */
            else {
                answer -= 2
            }
        }

        return answer.toInt()
    }
}