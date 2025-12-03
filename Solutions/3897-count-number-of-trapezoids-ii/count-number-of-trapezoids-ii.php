class Solution {

    /**
     * @param Integer[][] $points
     * @return Integer
     */
    function countTrapezoids($points) {

        // Count number of points
        $n = count($points);

        // Define gcd helper using recursion
        $gcd = function($a, $b) use (&$gcd) {
            // If b is zero, return absolute value of a
            return $b == 0 ? abs($a) : $gcd($b, $a % $b);
        };

        // Hash map: slope → list of intercept keys
        $slope_to_intercept = [];

        // Hash map: midpoint → list of slope keys
        $mid_to_slope = [];

        // Loop over all point pairs for segments
        for ($i = 0; $i < $n; $i++) {

            // Extract first point
            $x1 = $points[$i][0];
            $y1 = $points[$i][1];

            // Pair with all following points
            for ($j = $i + 1; $j < $n; $j++) {

                // Extract second point
                $x2 = $points[$j][0];
                $y2 = $points[$j][1];

                // Compute dx, dy
                $dx = $x2 - $x1;
                $dy = $y2 - $y1;

                // ---------------------------
                // Compute slope key
                // ---------------------------
                if ($dx == 0) {
                    // Vertical line → infinite slope
                    $slope_key = "INF";
                } else {
                    // Reduce dy/dx by gcd
                    $g = $gcd($dx, $dy);

                    // Normalized dx and dy
                    $dxn = intdiv($dx, $g);
                    $dyn = intdiv($dy, $g);

                    // Normalize direction so dx > 0
                    if ($dxn < 0) {
                        $dxn = -$dxn;
                        $dyn = -$dyn;
                    }

                    // Build slope key as string
                    $slope_key = $dyn . "/" . $dxn;
                }

                // ---------------------------
                // Compute intercept key
                // ---------------------------
                if ($dx == 0) {
                    // For vertical line, intercept = x coordinate
                    $intercept_key = "x=" . $x1;
                } else {
                    // Compute integer-based intercept:
                    // b_num = y1*dx - x1*dy
                    $num = $y1 * $dx - $x1 * $dy;
                    $den = $dx;

                    // Reduce using gcd
                    $g = $gcd($num, $den);

                    // Normalize num, den
                    $num = intdiv($num, $g);
                    $den = intdiv($den, $g);

                    // Ensure denominator positive
                    if ($den < 0) {
                        $num = -$num;
                        $den = -$den;
                    }

                    // Build intercept key
                    $intercept_key = $num . "/" . $den;
                }

                // ---------------------------
                // Compute midpoint key
                // ---------------------------
                // Add coordinates of endpoints
                $mid_x = $x1 + $x2;
                $mid_y = $y1 + $y2;

                // Unique encoding of midpoint
                $mid_key = $mid_x * 2000000007 + $mid_y;

                // Store intercept under its slope
                $slope_to_intercept[$slope_key][] = $intercept_key;

                // Store slope under its midpoint
                $mid_to_slope[$mid_key][] = $slope_key;
            }
        }

        // Result accumulator
        $ans = 0;

        // ---------------------------
        // Count trapezoids
        // ---------------------------
        foreach ($slope_to_intercept as $intercepts) {

            // Need at least 2 segments
            if (count($intercepts) < 2) continue;

            // Count occurrences of each intercept
            $freq = [];

            // Build frequency map
            foreach ($intercepts as $b) {
                if (!isset($freq[$b])) $freq[$b] = 0;
                $freq[$b]++;
            }

            // Count cross-intercept pairs
            $sum = 0;

            // For each intercept group
            foreach ($freq as $count) {
                // Add sum * count to answer
                $ans += $sum * $count;

                // Accumulate
                $sum += $count;
            }
        }

        // ---------------------------
        // Subtract parallelograms
        // ---------------------------
        foreach ($mid_to_slope as $slopes) {

            // Need at least 2 segments
            if (count($slopes) < 2) continue;

            // Count occurrences of slopes
            $freq = [];

            // Build frequency map
            foreach ($slopes as $k) {
                if (!isset($freq[$k])) $freq[$k] = 0;
                $freq[$k]++;
            }

            // Count cross-slope pairs
            $sum = 0;

            foreach ($freq as $count) {
                // Subtract parallelogram pairs
                $ans -= $sum * $count;

                // Accumulate
                $sum += $count;
            }
        }

        // Return final result
        return $ans;
    }
}
