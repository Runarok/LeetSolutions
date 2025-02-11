class Solution {

    /**
     * @param Integer[] $nums
     * @param Integer $target
     * @return Integer[]
     */
    function twoSum($nums, $target) {
        // Array of size 2 to store indices
        $result = [0, 0];

        // Brute force checking to find the solution
        for ($i = 0; $i < count($nums); $i++) {
            for ($j = $i + 1; $j < count($nums); $j++) {
                if ($nums[$i] + $nums[$j] == $target) {
                    $result[0] = $i;
                    $result[1] = $j;
                    return $result;
                }
            }
        }

        return null;  // If no solution is found, return null
    }
}