class Solution {

    /**
     * @param Integer[][] $intervals
     * @return Integer
     */
    function removeCoveredIntervals($intervals) {

        // Sort the intervals.
        //
        // Primary sort:
        //   Smaller starting point comes first.
        //
        // Secondary sort (when starts are equal):
        //   Larger ending point comes first.
        //
        // Example:
        // [1,5], [1,3]
        //
        // We want [1,5] first so that [1,3] is recognized
        // as being covered.
        usort($intervals, function($a, $b) {

            // Different starting points
            if ($a[0] != $b[0]) {
                return $a[0] <=> $b[0];
            }

            // Same starting point
            // Larger ending point first
            return $b[1] <=> $a[1];
        });

        // Number of intervals that remain
        $count = 0;

        // Maximum ending value seen so far.
        // Start with -1 because interval ends are always >= 1.
        $maxEnd = -1;

        // Check every interval
        foreach ($intervals as $interval) {

            // Current interval's ending value
            $end = $interval[1];

            // If current end is <= maxEnd,
            // then this interval is completely covered
            // by one we've already processed.
            if ($end <= $maxEnd) {
                continue;
            }

            // Otherwise, this interval is NOT covered.
            $count++;

            // Update the farthest ending point.
            $maxEnd = $end;
        }

        // Return the number of intervals left.
        return $count;
    }
}