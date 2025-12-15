class Solution {

    /**
     * Counts the number of smooth descent periods.
     *
     * @param Integer[] $prices
     * @return Integer
     */
    function getDescentPeriods($prices) {

        // Total number of smooth descent periods
        $result = 0;

        // Length of the current smooth descent streak
        // At minimum, every single day counts as 1
        $currentStreak = 0;

        // Get the total number of days
        $n = count($prices);

        // Loop through each day's price
        for ($i = 0; $i < $n; $i++) {

            // If this is NOT the first day
            // AND the price decreased by exactly 1 from yesterday
            if ($i > 0 && $prices[$i] == $prices[$i - 1] - 1) {

                // Extend the previous smooth descent streak
                $currentStreak++;

            } else {
                // Otherwise, the descent breaks
                // Start a new smooth descent period
                $currentStreak = 1;
            }

            // Add the current streak length to the result
            // Each streak contributes all its valid subarrays
            $result += $currentStreak;
        }

        // Return the total number of smooth descent periods
        return $result;
    }
}
