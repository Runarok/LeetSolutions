class Solution {

    /**
     * @param Integer[] $nums   // initial array
     * @param Integer[][] $queries  // list of queries
     * @return Integer  // XOR of final array
     */
    function xorAfterQueries($nums, $queries) {
        
        // Define MOD = 10^9 + 7
        $MOD = 1000000007;
        
        // Length of nums
        $n = count($nums);
        
        // Process each query one by one
        foreach ($queries as $query) {
            
            // Extract query parameters
            $li = $query[0]; // starting index
            $ri = $query[1]; // ending index
            $ki = $query[2]; // step size
            $vi = $query[3]; // multiplier
            
            // Start from index li
            $idx = $li;
            
            // Loop until idx exceeds ri
            while ($idx <= $ri) {
                
                // Multiply current element by vi and take modulo
                $nums[$idx] = ($nums[$idx] * $vi) % $MOD;
                
                // Move to next index based on step size ki
                $idx += $ki;
            }
        }
        
        // Now compute XOR of all elements in the final array
        $xor = 0;
        
        for ($i = 0; $i < $n; $i++) {
            $xor ^= $nums[$i];
        }
        
        // Return final XOR result
        return $xor;
    }
}