class Solution {

    /**
     * @param Integer[][] $lcp
     * @return String
     */
    function findTheString($lcp) {
        $n = count($lcp);
        
        // Step 0: Basic validation
        // Diagonal must be n - i
        for ($i = 0; $i < $n; $i++) {
            if ($lcp[$i][$i] != $n - $i) {
                return "";
            }
        }

        // -----------------------------
        // Step 1: Union-Find (DSU)
        // -----------------------------
        $parent = range(0, $n - 1);

        // Find with path compression
        $find = function($x) use (&$parent, &$find) {
            if ($parent[$x] != $x) {
                $parent[$x] = $find($parent[$x]);
            }
            return $parent[$x];
        };

        // Union
        $union = function($a, $b) use (&$parent, &$find) {
            $pa = $find($a);
            $pb = $find($b);
            if ($pa != $pb) {
                $parent[$pb] = $pa;
            }
        };

        // -----------------------------
        // Step 2: Merge indices
        // -----------------------------
        for ($i = 0; $i < $n; $i++) {
            for ($j = 0; $j < $n; $j++) {
                if ($lcp[$i][$j] > 0) {
                    $union($i, $j);
                }
            }
        }

        // -----------------------------
        // Step 3: Assign characters
        // -----------------------------
        $charMap = [];  // root -> character
        $currentChar = 'a';
        $word = array_fill(0, $n, '');

        for ($i = 0; $i < $n; $i++) {
            $root = $find($i);

            if (!isset($charMap[$root])) {
                if ($currentChar > 'z') {
                    return ""; // more than 26 groups
                }
                $charMap[$root] = $currentChar;
                $currentChar++;
            }

            $word[$i] = $charMap[$root];
        }

        $word = implode('', $word);

        // -----------------------------
        // Step 4: Validate LCP
        // -----------------------------
        // Build actual LCP matrix from word
        $dp = array_fill(0, $n + 1, array_fill(0, $n + 1, 0));

        // dp[i][j] = LCP of suffix i and j
        for ($i = $n - 1; $i >= 0; $i--) {
            for ($j = $n - 1; $j >= 0; $j--) {
                if ($word[$i] == $word[$j]) {
                    $dp[$i][$j] = 1 + $dp[$i + 1][$j + 1];
                } else {
                    $dp[$i][$j] = 0;
                }

                // Compare with given matrix
                if ($dp[$i][$j] != $lcp[$i][$j]) {
                    return "";
                }
            }
        }

        return $word;
    }
}