class Solution {

    /**
     * @param Integer[] $nums
     * @return NULL
     */
    function sortColors(&$nums) {
        // Initialize pointers:
        // low points to the next position where we want to place a '0'
        $low = 0;
        // mid is used to traverse the array
        $mid = 0;
        // high points to the next position where we want to place a '2'
        $high = count($nums) - 1;

        // We will continue the loop as long as mid doesn't exceed high
        while ($mid <= $high) {
            // Case 1: If nums[mid] is 0
            if ($nums[$mid] == 0) {
                // Swap nums[low] and nums[mid], moving the 0 to the correct position
                list($nums[$low], $nums[$mid]) = array($nums[$mid], $nums[$low]);
                
                // Now that we've placed a 0, we can increment low and mid to process the next elements
                $low++;
                $mid++;
            }
            // Case 2: If nums[mid] is 1
            elseif ($nums[$mid] == 1) {
                // 1 is already in its correct position, so just move mid forward
                $mid++;
            }
            // Case 3: If nums[mid] is 2
            else {
                // Swap nums[mid] and nums[high], moving the 2 to the correct position
                list($nums[$high], $nums[$mid]) = array($nums[$mid], $nums[$high]);
                
                // After swapping, we decrement high, but we don't increment mid yet, 
                // because the new element at mid may need further processing
                $high--;
            }
        }
    }
}
