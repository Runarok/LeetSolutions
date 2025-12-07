class Solution {

    /**
     * Count how many odd numbers exist between low and high (inclusive).
     *
     * An odd number is any number where number % 2 == 1.
     *
     * Instead of looping from low to high (which can be very large, up to 10^9),
     * we use a mathematical formula:
     *
     *   Number of odd numbers from 0 to N  =  floor((N + 1) / 2)
     *
     * Example:
     *   N = 7 → odds are [1, 3, 5, 7] → 4 odds → floor((7 + 1)/2) = 4
     *   N = 8 → odds are [1, 3, 5, 7] → 4 odds → floor((8 + 1)/2) = 4
     *
     * To get the count of odds in the interval [low, high], we subtract:
     *
     *   odds up to high  −  odds up to (low - 1)
     *
     * But this can be simplified to a clean formula:
     *
     *   count = floor((high + 1) / 2) − floor(low / 2)
     *
     * This works because:
     *   - floor((high + 1) / 2) gives number of odds ≤ high
     *   - floor(low / 2) gives number of odds < low
     *
     * @param Integer $low  Starting number (inclusive)
     * @param Integer $high Ending number (inclusive)
     * @return Integer      The number of odd integers in that range
     */
    function countOdds($low, $high) {

        // Count how many odd numbers are ≤ high
        $oddsUpToHigh = intdiv($high + 1, 2);

        // Count how many odd numbers are < low
        $oddsBeforeLow = intdiv($low, 2);

        // The difference gives the number of odd integers in [low, high]
        return $oddsUpToHigh - $oddsBeforeLow;
    }
}
