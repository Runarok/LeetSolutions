class Solution {

    /**
     * @param Integer[] $ratings
     * @return Integer
     */
    function candy($ratings) {
        $n = count($ratings);
        
        // Edge case: if there's only one child, give 1 candy
        if ($n == 1) return 1;
        
        // Initialize candies array where each child gets at least 1 candy
        $candies = array_fill(0, $n, 1);
        
        // Step 1: Traverse from left to right
        // If the current child has a higher rating than the previous child,
        // then current child must have more candies than the previous child
        for ($i = 1; $i < $n; $i++) {
            if ($ratings[$i] > $ratings[$i - 1]) {
                $candies[$i] = $candies[$i - 1] + 1;
            }
        }
        
        // Step 2: Traverse from right to left
        // If the current child has a higher rating than the next child,
        // then current child must have more candies than the next child
        // But also, it must maintain the max between what it currently has and this condition
        for ($i = $n - 2; $i >= 0; $i--) {
            if ($ratings[$i] > $ratings[$i + 1]) {
                $candies[$i] = max($candies[$i], $candies[$i + 1] + 1);
            }
        }
        
        // Step 3: Sum up all the candies to get the minimum required candies
        $result = 0;
        for ($i = 0; $i < $n; $i++) {
            $result += $candies[$i];
        }
        
        return $result;
    }
}
