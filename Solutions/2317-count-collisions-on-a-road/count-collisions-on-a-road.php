class Solution {

    /**
     * @param String $directions
     * @return Integer
     */
    function countCollisions($directions) {
        // Convert to array for easy indexing
        $dirs = str_split($directions);
        $n = count($dirs);

        // ---------------------------------------------------
        // STEP 1: Trim cars on the far left that move left ('L')
        // These cars will never collide because nothing is on their left.
        // ---------------------------------------------------
        $left = 0;
        while ($left < $n && $dirs[$left] === 'L') {
            $left++;
        }

        // ---------------------------------------------------
        // STEP 2: Trim cars on the far right that move right ('R')
        // These cars will never collide because nothing is on their right.
        // ---------------------------------------------------
        $right = $n - 1;
        while ($right >= 0 && $dirs[$right] === 'R') {
            $right--;
        }

        // ---------------------------------------------------
        // STEP 3: Count all moving cars ('L' or 'R') between left and right
        // All these cars will eventually collide and stop.
        //
        // Why?
        // - Any 'R' here runs into a stationary area to its right and crashes.
        // - Any 'L' here runs into a stationary area or a stopped 'R' to its left.
        // - 'S' remains stationary and does not add to the count.
        //
        // Each moving car contributes exactly 1 collision.
        // ---------------------------------------------------
        $collisions = 0;
        for ($i = $left; $i <= $right; $i++) {
            if ($dirs[$i] === 'L' || $dirs[$i] === 'R') {
                // This moving car will collide and stop
                $collisions++;
            }
        }

        return $collisions;
    }
}
