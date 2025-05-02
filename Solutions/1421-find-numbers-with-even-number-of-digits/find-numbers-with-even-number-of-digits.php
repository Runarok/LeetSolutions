class Solution {

    /**
     * @param Integer[] $nums
     * @return Integer
     */
    function findNumbers($nums) {
        $count = 0;  // Initialize the counter for numbers with an even number of digits
        
        foreach ($nums as $num) {
            // Convert the number to string and check if the number of digits is even
            if (strlen((string)$num) % 2 == 0) {
                $count++;  // Increment the counter if the number of digits is even
            }
        }
        
        return $count;  // Return the total count
    }
}
