object Solution {
    def maxOperations(s: String): Int = {
        // -------------------------------------------------------
        // Variables initialization
        // -------------------------------------------------------
        
        var countOne = 0     // Keeps track of how many '1's have appeared so far
        var ans = 0L         // Total number of operations (use Long to prevent overflow)
        var i = 0            // Current index in the string
        
        // -------------------------------------------------------
        // Main traversal loop
        // We iterate through each character in the string.
        // -------------------------------------------------------
        
        while (i < s.length) {
            
            if (s(i) == '0') {
                // ---------------------------------------------------
                // When we encounter a '0', we have found a segment
                // that all previous '1's can potentially "cross".
                // Each such zero segment contributes `countOne`
                // operations — one for each '1' before this block.
                // ---------------------------------------------------
                
                // Move through all consecutive '0's in this block
                // so we handle them together as one "segment".
                while (i + 1 < s.length && s(i + 1) == '0') {
                    i += 1
                }
                
                // Add the contribution of this block of zeros
                ans += countOne
                
            } else {
                // ---------------------------------------------------
                // If the current character is '1', we increase the count
                // of '1's seen so far. These '1's can contribute to
                // operations when we later encounter zeros.
                // ---------------------------------------------------
                countOne += 1
            }
            
            // Move to the next character in the string
            i += 1
        }
        
        // -------------------------------------------------------
        // Return the total number of operations.
        // We convert ans to Int since the problem constraints
        // guarantee the result fits in Int range.
        // -------------------------------------------------------
        ans.toInt
    }
}
