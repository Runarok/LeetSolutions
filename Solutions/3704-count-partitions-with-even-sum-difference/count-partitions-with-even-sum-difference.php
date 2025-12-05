class Solution {

    /**
     * @param Integer[] $nums
     * @return Integer
     */
    function countPartitions($nums) {
        $n = count($nums);
        $total = array_sum($nums);
        
        // If total sum is odd, no partition can give even difference
        if ($total % 2 != 0) return 0;

        // Otherwise all (n-1) partitions are valid
        return $n - 1;
    }
}
