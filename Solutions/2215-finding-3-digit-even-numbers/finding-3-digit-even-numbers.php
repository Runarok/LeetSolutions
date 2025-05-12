class Solution {

    /**
     * @param Integer[] $digits
     * @return Integer[]
     */
    function findEvenNumbers($digits) {
        // Initialize an empty set to store the unique even numbers
        $nums = [];
        $n = count($digits);

        // Traverse through the digits array with three nested loops for each digit position
        for ($i = 0; $i < $n; $i++) {
            for ($j = 0; $j < $n; $j++) {
                for ($k = 0; $k < $n; $k++) {
                    // Ensure we don't use the same digit in multiple positions
                    if ($i == $j || $j == $k || $i == $k) {
                        continue;
                    }
                    
                    // Form a number using digits i, j, and k
                    $num = $digits[$i] * 100 + $digits[$j] * 10 + $digits[$k];

                    // Check if the number is valid:
                    // 1. It must be a 3-digit number (>= 100)
                    // 2. It must be even (last digit must be 0, 2, 4, 6, or 8)
                    if ($num >= 100 && $num % 2 == 0) {
                        // Add the valid number to the set (array for uniqueness)
                        $nums[$num] = true;
                    }
                }
            }
        }

        // Sort the numbers in ascending order and return them as a list
        $sorted = array_keys($nums);
        sort($sorted);
        return $sorted;
    }
}
