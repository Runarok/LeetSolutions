class Solution {

    /**
     * @param Integer[] $nums
     * @param Integer[][] $queries
     * @return Boolean
     */
    public function isZeroArray($nums, $queries) {
        // Get the length of the nums array
        $n = count($nums);
        
        // Initialize deltaArray to track the range updates.
        // The size of deltaArray is n + 1 to handle the case when we decrement index 'right + 1'.
        // We initialize all elements to zero.
        $deltaArray = array_fill(0, $n + 1, 0);
        
        // Process each query to update the deltaArray
        foreach ($queries as $query) {
            $left = $query[0];  // The start index of the range (inclusive)
            $right = $query[1]; // The end index of the range (inclusive)
            
            // Increment at the start index of the range to begin the decrement operation
            $deltaArray[$left] += 1;
            
            // Decrement at the index 'right + 1' to end the decrement operation after the 'right' index
            // This ensures that the decrement operation stops at index 'right'
            if ($right + 1 < $n) {
                $deltaArray[$right + 1] -= 1;
            }
        }
        
        // Initialize operationCounts array to store the cumulative decrements for each index
        $operationCounts = array_fill(0, $n, 0);
        
        // Variable to keep track of the cumulative number of operations
        $currentOperations = 0;
        
        // Compute the cumulative number of operations for each index
        for ($i = 0; $i < $n; $i++) {
            // Update currentOperations by adding the value from deltaArray at index i
            $currentOperations += $deltaArray[$i];
            
            // Store the cumulative operation count at index i
            $operationCounts[$i] = $currentOperations;
        }
        
        // Now we check if it's possible to make the array a zero array
        for ($i = 0; $i < $n; $i++) {
            // For each index i in nums, check if we have enough operations to reduce nums[i] to zero
            // If operationCounts[i] is less than nums[i], we can't bring nums[i] to zero.
            if ($operationCounts[$i] < $nums[$i]) {
                return false; // If any element can't be reduced to zero, return false
            }
        }
        
        // If we can reduce all elements to zero, return true
        return true;
    }
}
