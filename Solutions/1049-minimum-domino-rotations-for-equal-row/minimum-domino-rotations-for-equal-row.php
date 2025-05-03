class Solution {
    /**
     * @param Integer[] $tops
     * @param Integer[] $bottoms
     * @return Integer
     */
    function minDominoRotations($tops, $bottoms) {
        // Loop through all possible values (1 to 6) that we might want to make equal
        for ($i = 1; $i <= 6; $i++) {
            // Variables to count how many rotations are needed for each row
            $top_rotations = 0;
            $bottom_rotations = 0;
            $valid = true; // Flag to check if it's possible to make all elements equal to $i
            
            // Check each domino
            for ($j = 0; $j < count($tops); $j++) {
                // If neither the top nor the bottom has the value $i, it's not possible to make $i equal in this domino
                if ($tops[$j] !== $i && $bottoms[$j] !== $i) {
                    $valid = false; // No valid rotation can make this domino match $i
                    break; // No need to continue checking this value $i, we can move to the next value
                }
                
                // If the top value is not $i, we need to rotate this domino to make the top equal to $i
                if ($tops[$j] !== $i) {
                    $top_rotations++; // Count the number of rotations needed for the top row
                }
                
                // If the bottom value is not $i, we need to rotate this domino to make the bottom equal to $i
                if ($bottoms[$j] !== $i) {
                    $bottom_rotations++; // Count the number of rotations needed for the bottom row
                }
            }
            
            // If it's possible to make all values equal to $i in either row
            if ($valid) {
                // Return the minimum number of rotations needed: either for the top row or the bottom row
                return min($top_rotations, $bottom_rotations);
            }
        }
        
        // If no value between 1 and 6 can make all dominoes equal in either row, return -1
        return -1;
    }
}
