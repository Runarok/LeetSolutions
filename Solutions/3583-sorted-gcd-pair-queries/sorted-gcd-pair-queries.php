class Solution {

    /**
     * @param Integer[] $nums
     * @param Integer[] $queries
     * @return Integer[]
     */
    function gcdValues($nums, $queries) {

        // Maximum value in nums
        $maxVal = max($nums);

        // Frequency of every number
        $freq = array_fill(0, $maxVal + 1, 0);

        foreach ($nums as $x) {
            $freq[$x]++;
        }

        // exactPairs[g] = number of pairs whose gcd is exactly g
        $exactPairs = array_fill(0, $maxVal + 1, 0);

        // Process divisors from largest to smallest
        for ($g = $maxVal; $g >= 1; $g--) {

            // Count how many numbers are divisible by g
            $cnt = 0;
            for ($m = $g; $m <= $maxVal; $m += $g) {
                $cnt += $freq[$m];
            }

            // Total pairs with gcd multiple of g
            $pairs = intdiv($cnt * ($cnt - 1), 2);

            // Remove pairs already assigned to multiples of g
            for ($m = $g * 2; $m <= $maxVal; $m += $g) {
                $pairs -= $exactPairs[$m];
            }

            // Remaining pairs have gcd exactly g
            $exactPairs[$g] = $pairs;
        }

        // Prefix counts of gcd values in sorted gcdPairs
        $prefix = [];
        $running = 0;

        for ($g = 1; $g <= $maxVal; $g++) {
            $running += $exactPairs[$g];
            $prefix[$g] = $running;
        }

        $ans = [];

        // Answer each query using binary search
        foreach ($queries as $k) {

            // We need first gcd whose prefix > k
            $target = $k + 1;

            $l = 1;
            $r = $maxVal;

            while ($l < $r) {
                $mid = intdiv($l + $r, 2);

                if ($prefix[$mid] >= $target) {
                    $r = $mid;
                } else {
                    $l = $mid + 1;
                }
            }

            $ans[] = $l;
        }

        return $ans;
    }
}