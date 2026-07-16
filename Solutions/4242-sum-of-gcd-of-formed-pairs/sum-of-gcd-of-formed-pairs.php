class Solution {

    /**
     * @param Integer[] $nums
     * @return Integer
     */
    function gcdSum($nums) {

        // Number of elements
        $n = count($nums);

        // This array will store gcd(nums[i], maximum element from 0..i)
        $prefixGcd = [];

        // Current maximum while traversing
        $currentMax = 0;

        // Build prefixGcd array
        for ($i = 0; $i < $n; $i++) {

            // Update prefix maximum
            if ($nums[$i] > $currentMax) {
                $currentMax = $nums[$i];
            }

            // Store gcd of current number and prefix maximum
            $prefixGcd[] = $this->gcd($nums[$i], $currentMax);
        }

        // Sort the array
        sort($prefixGcd);

        // Two pointers
        $left = 0;
        $right = $n - 1;

        // Final answer
        $sum = 0;

        // Pair smallest with largest
        while ($left < $right) {

            // Add gcd of the current pair
            $sum += $this->gcd($prefixGcd[$left], $prefixGcd[$right]);

            // Move both pointers
            $left++;
            $right--;
        }

        return $sum;
    }

    /**
     * Euclidean Algorithm for GCD
     *
     * @param Integer $a
     * @param Integer $b
     * @return Integer
     */
    private function gcd($a, $b) {

        while ($b != 0) {
            $temp = $a % $b;
            $a = $b;
            $b = $temp;
        }

        return $a;
    }
}