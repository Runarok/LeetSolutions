class Solution {

    /**
     * Check if two strings can be made equal by swapping:
     * - indices (0,2)
     * - indices (1,3)
     *
     * @param String $s1
     * @param String $s2
     * @return Boolean
     */
    function canBeEqual($s1, $s2) {

        // ---------------------------
        // SOLUTION 1 (faster approach)
        // ---------------------------

        // Case 1: Strings are already equal
        if ($s1 == $s2) return true;

        // Case 2: Swap positions 0 and 2 in s1
        // Check if swapping makes s1 equal to s2
        elseif (
            $s1[0] == $s2[2] && // first char matches third
            $s1[2] == $s2[0] && // third char matches first
            $s1[1] == $s2[1] && // second unchanged
            $s1[3] == $s2[3]    // fourth unchanged
        ) return true;

        // Case 3: Swap positions 1 and 3 in s1
        elseif (
            $s1[0] == $s2[0] && // first unchanged
            $s1[2] == $s2[2] && // third unchanged
            $s1[1] == $s2[3] && // second matches fourth
            $s1[3] == $s2[1]    // fourth matches second
        ) return true;

        // Case 4: Swap both pairs (0,2) and (1,3)
        elseif (
            $s1[0] == $s2[2] &&
            $s1[2] == $s2[0] &&
            $s1[1] == $s2[3] &&
            $s1[3] == $s2[1]
        ) return true;

        // If none of the valid transformations match
        else return false;


        // ---------------------------
        // SOLUTION 2 (alternative approach)
        // ---------------------------
        // This part is unreachable because of early returns above,
        // but kept here for explanation.

        // Create copies of s1 to apply swaps
        $copy1 = $copy2 = $copy3 = $s1;

        // Swap indices (0,2)
        [$copy1[0], $copy1[2]] = [$copy1[2], $copy1[0]];

        // Swap indices (1,3)
        [$copy2[1], $copy2[3]] = [$copy2[3], $copy2[1]];

        // Swap both pairs at once:
        // (0,2) and (1,3)
        [$copy3[0], $copy3[1], $copy3[2], $copy3[3]] =
            [$copy3[2], $copy3[3], $copy3[0], $copy3[1]];

        // Check if any transformed version equals s2
        return $s1 == $s2 ||
               $copy1 == $s2 ||
               $copy2 == $s2 ||
               $copy3 == $s2;
    }
}