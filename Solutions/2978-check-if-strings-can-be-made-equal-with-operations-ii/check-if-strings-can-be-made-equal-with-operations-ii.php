class Solution {

    /**
     * @param String $s1
     * @param String $s2
     * @return Boolean
     */
    function checkStrings($s1, $s2) {
        
        // Length of strings
        $n = strlen($s1);

        // Frequency arrays for:
        // Even indices and Odd indices separately
        // 26 for lowercase English letters
        $even1 = array_fill(0, 26, 0);
        $odd1  = array_fill(0, 26, 0);
        $even2 = array_fill(0, 26, 0);
        $odd2  = array_fill(0, 26, 0);

        // Traverse both strings
        for ($i = 0; $i < $n; $i++) {

            // Convert character to index (0–25)
            $c1 = ord($s1[$i]) - ord('a');
            $c2 = ord($s2[$i]) - ord('a');

            // If index is even
            if ($i % 2 == 0) {
                // Count in even arrays
                $even1[$c1]++;
                $even2[$c2]++;
            } else {
                // Count in odd arrays
                $odd1[$c1]++;
                $odd2[$c2]++;
            }
        }

        // Compare even frequency arrays
        for ($i = 0; $i < 26; $i++) {
            if ($even1[$i] != $even2[$i]) {
                return false; // mismatch found
            }
        }

        // Compare odd frequency arrays
        for ($i = 0; $i < 26; $i++) {
            if ($odd1[$i] != $odd2[$i]) {
                return false; // mismatch found
            }
        }

        // If both even and odd groups match
        return true;
    }
}