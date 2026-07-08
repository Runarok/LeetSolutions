class Solution {

    /**
     * @param String $s
     * @param Integer[][] $queries
     * @return Integer[]
     */
    function sumAndMultiply($s, $queries) {
        $MOD = 1000000007;
        $n = strlen($s);

        // Store only non-zero digits.
        $digits = [];
        $pos = [];

        // Prefix sum of non-zero digits.
        $digitPrefix = [0];

        // Prefix value of concatenated number.
        // pref[i] = value of first i non-zero digits.
        $pref = [0];

        // pow10[i] = 10^i % MOD
        $pow10 = [1];

        foreach (str_split($s) as $i => $ch) {
            if ($ch !== '0') {
                $d = intval($ch);
                $digits[] = $d;
                $pos[] = $i;

                $digitPrefix[] = $digitPrefix[count($digitPrefix) - 1] + $d;

                $pow10[] = ($pow10[count($pow10) - 1] * 10) % $MOD;

                $pref[] = ($pref[count($pref) - 1] * 10 + $d) % $MOD;
            }
        }

        $k = count($digits);

        // nextIdx[i] = first non-zero digit index whose position >= i
        $nextIdx = array_fill(0, $n + 1, $k);
        $idx = $k - 1;
        for ($i = $n - 1; $i >= 0; $i--) {
            while ($idx >= 0 && $pos[$idx] >= $i) {
                $nextIdx[$i] = $idx;
                $idx--;
            }
            if ($i + 1 < $n && $nextIdx[$i] == $k) {
                $nextIdx[$i] = $nextIdx[$i + 1];
            }
        }

        $ans = [];

        foreach ($queries as $q) {
            $l = $q[0];
            $r = $q[1];

            $left = $nextIdx[$l];

            if ($left == $k || $pos[$left] > $r) {
                $ans[] = 0;
                continue;
            }

            // last non-zero digit <= r
            $lo = $left;
            $hi = $k - 1;
            while ($lo < $hi) {
                $mid = intdiv($lo + $hi + 1, 2);
                if ($pos[$mid] <= $r) {
                    $lo = $mid;
                } else {
                    $hi = $mid - 1;
                }
            }
            $right = $lo;

            $len = $right - $left + 1;

            $x = ($pref[$right + 1] - ($pref[$left] * $pow10[$len]) % $MOD + $MOD) % $MOD;
            $sum = $digitPrefix[$right + 1] - $digitPrefix[$left];

            $ans[] = ($x * ($sum % $MOD)) % $MOD;
        }

        return $ans;
    }
}