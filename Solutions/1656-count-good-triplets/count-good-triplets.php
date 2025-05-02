class Solution {

    /**
     * @param Integer[] $arr
     * @param Integer $a
     * @param Integer $b
     * @param Integer $c
     * @return Integer
     */
    function countGoodTriplets($arr, $a, $b, $c) {
        $n = count($arr);
        $count = 0;

        // Use three nested loops to go through all triplets (i, j, k) where 0 <= i < j < k
        for ($i = 0; $i < $n - 2; $i++) {
            for ($j = $i + 1; $j < $n - 1; $j++) {
                for ($k = $j + 1; $k < $n; $k++) {
                    // Check if the current triplet satisfies all three conditions
                    if (abs($arr[$i] - $arr[$j]) <= $a && abs($arr[$j] - $arr[$k]) <= $b && abs($arr[$i] - $arr[$k]) <= $c) {
                        $count++;  // If the triplet is valid, increment the count
                    }
                }
            }
        }

        return $count;  // Return the total number of valid triplets
    }
}
