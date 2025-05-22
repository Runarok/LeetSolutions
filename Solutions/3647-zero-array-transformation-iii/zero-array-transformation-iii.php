class Solution {

    /**
     * @param Integer[] $nums
     * @param Integer[][] $queries
     * @return Integer
     */
    function maxRemoval($nums, $queries) {
        // Step 1: Sort the queries by their left boundary.
        // This is necessary because we want to process queries in order of their left index.
        // Sorting the queries ensures that we always deal with the earliest possible left index first.
        usort($queries, function($a, $b) {
            return $a[0] - $b[0];  // Compare the left indices (a[0] and b[0]) of the queries
        });

        // Step 2: Initialize the max-heap (SplMaxHeap in PHP).
        // A max-heap will help us efficiently manage and retrieve the rightmost index of the queries.
        $heap = new SplMaxHeap();
        
        // Step 3: Initialize the delta array to store the range decrements.
        // deltaArray helps track how the values in nums are being reduced over time by the queries.
        // It's initialized to all zeros and is of length nums.length + 1 to handle the range updates properly.
        $deltaArray = array_fill(0, count($nums) + 1, 0); 

        // Step 4: Initialize operations variable to track the total number of operations applied to nums.
        // The `operations` variable accumulates the number of decrements applied as we process the array.
        $operations = 0;
        
        // Step 5: Process each element in nums.
        $j = 0; // This will be used to track the queries we process.
        
        // Iterate over the nums array
        for ($i = 0; $i < count($nums); $i++) {
            // Step 6: Update the operations based on the delta array at position $i.
            $operations += $deltaArray[$i]; // Accumulate the total decrement at index $i

            // Step 7: Process all queries that start at index $i.
            // If a query starts at index $i, we push its rightmost boundary into the heap.
            // This helps us track which query ranges are still active at the current index $i.
            while ($j < count($queries) && $queries[$j][0] === $i) {
                $heap->insert($queries[$j][1]); // Push the rightmost boundary (r) of the query into the heap
                $j++; // Move to the next query
            }

            // Step 8: Try to apply the remaining operations to nums[i].
            // We continue applying operations (from the heap) as long as operations < nums[i]
            // and we have queries whose right boundary (r) is >= current index $i.
            while ($operations < $nums[$i] && !$heap->isEmpty() && $heap->top() >= $i) {
                // If there is still a deficit in operations and the top of the heap is valid, apply one operation
                $operations += 1; // Apply one decrement operation
                $index = $heap->extract(); // Extract the query's right boundary (r)
                $deltaArray[$index + 1] -= 1; // Mark that the operation stops after index r by adjusting the delta array
            }
            
            // Step 9: Check if we were able to apply enough operations to reduce nums[i] to zero.
            // If after all possible operations we still can't reduce nums[i] to zero, return -1.
            if ($operations < $nums[$i]) {
                return -1;  // It's impossible to make nums[i] zero, so we return -1
            }
        }

        // Step 10: The final result is the number of queries still in the heap.
        // This represents the queries we *could* remove while still being able to zero out nums.
        return $heap->count(); // Return the number of queries left in the heap (i.e., the queries we couldn't remove)
    }
}
