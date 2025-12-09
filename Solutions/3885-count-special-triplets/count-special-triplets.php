class Solution {

    /**
     * @param Integer[] $nums
     * @return Integer
     */
    function specialTriplets($nums) {
        $MOD = 1_000_000_007;
        $n = count($nums);

        // Frequency map of all values on the right side (initially whole array)
        $right = [];
        foreach ($nums as $v) {
            if (!isset($right[$v])) $right[$v] = 0;
            $right[$v]++;
        }

        // Frequency map of values seen so far on the left
        $left = [];
        $result = 0;

        // Iterate through each index j as the middle element of the triplet
        for ($j = 0; $j < $n; $j++) {
            $mid = $nums[$j];

            // This index j now moves from "right" to being the middle element,
            // so we remove nums[j] from the right-side frequency.
            $right[$mid]--;

            // The required value nums[i] and nums[k] must be double of mid.
            $target = $mid * 2;

            // How many valid left indices i exist?
            $leftCount = $left[$target] ?? 0;

            // How many valid right indices k exist?
            $rightCount = $right[$target] ?? 0;

            // All combinations form valid triplets.
            $result = ($result + ($leftCount * $rightCount) % $MOD) % $MOD;

            // Now this element becomes part of the left map for future j's
            if (!isset($left[$mid])) $left[$mid] = 0;
            $left[$mid]++;
        }

        return $result;
    }
}
