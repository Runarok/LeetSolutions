class Solution {

    /**
     * @param String $s
     * @return Integer
     */
    function maxActiveSectionsAfterTrade($s) {

        // Current number of active sections.
        $ones = substr_count($s, '1');

        // Add virtual '1' at both ends.
        $t = "1" . $s . "1";
        $m = strlen($t);

        // Build run-length encoding.
        $chars = [];
        $lens = [];

        $i = 0;
        while ($i < $m) {
            $j = $i;
            while ($j < $m && $t[$j] === $t[$i]) {
                $j++;
            }
            $chars[] = $t[$i];
            $lens[] = $j - $i;
            $i = $j;
        }

        $best = $ones;
        $k = count($chars);

        // Look for pattern:
        // 0-run, 1-run, 0-run
        // The middle 1-run is surrounded by zeros, so it can be removed.
        // Removing it merges the two zero-runs.
        // Flipping the merged zero-run gains (leftZero + rightZero) ones.
        for ($i = 1; $i < $k - 1; $i++) {
            if (
                $chars[$i] === '1' &&
                $chars[$i - 1] === '0' &&
                $chars[$i + 1] === '0'
            ) {
                $gain = $lens[$i - 1] + $lens[$i + 1];
                $best = max($best, $ones + $gain);
            }
        }

        return $best;
    }
}