class Solution {

    /**
     * Count the number of ways to divide the corridor
     * so that each section has exactly two seats.
     *
     * @param String $corridor
     * @return Integer
     */
    function numberOfWays($corridor) {

        // This will store the final answer
        // Start with 1 because we multiply choices as we go
        $ans = 1;

        // Count how many seats ('S') we have seen so far
        $seatCount = 0;

        // Position of the most recently seen seat
        // Used to count how many places we can put a divider
        $recentPosition = 0;

        // Modulo as required by the problem
        $mod = 1000000007;

        // Traverse the corridor character by character
        for ($i = 0; $i < strlen($corridor); ++$i) {

            // If we encounter a seat
            if ($corridor[$i] === 'S') {

                // Increment total seat count
                ++$seatCount;

                /**
                 * Key observation:
                 * - Every section must contain exactly 2 seats.
                 * - After we complete one section (2 seats),
                 *   the next section starts at the 3rd seat.
                 *
                 * When seatCount is:
                 * - odd and greater than 2 (3rd, 5th, 7th seat, ...)
                 *   we are starting a NEW section.
                 *
                 * The divider that ends the previous section
                 * can be placed anywhere between the previous seat
                 * and the current seat.
                 */
                if ($seatCount > 2 && $seatCount % 2 === 1) {

                    // Number of possible divider positions
                    // equals the distance between seats
                    $ans = ($ans * ($i - $recentPosition)) % $mod;
                }

                // Update the last seen seat position
                $recentPosition = $i;
            }
        }

        /**
         * Valid corridor conditions:
         * - Total number of seats must be even
         * - There must be at least one section (seatCount > 0)
         *
         * If not valid, return 0
         */
        return ($seatCount % 2 === 0 && $seatCount > 0) ? $ans : 0;
    }
}
