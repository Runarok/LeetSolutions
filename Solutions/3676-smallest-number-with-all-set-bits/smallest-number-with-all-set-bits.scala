object Solution {
    def smallestNumber(n: Int): Int = {
        // We are looking for the smallest number >= n
        // whose binary representation contains only 1s.
        
        // Example pattern of such numbers:
        // 1  -> 1 (binary "1")
        // 3  -> 11 (binary "11")
        // 7  -> 111 (binary "111")
        // 15 -> 1111 (binary "1111")
        // and so on...
        
        // Start with 1 bit set
        var bits = 1
        
        // Loop until we find a number >= n
        while (true) {
            // Compute number with all bits set for current 'bits' count.
            // (1 << bits) means 2^bits, so subtracting 1 gives all bits = 1.
            val allOnes = (1 << bits) - 1
            
            // Check if this number satisfies the condition (>= n)
            if (allOnes >= n) {
                // Found our smallest valid number, return it
                return allOnes
            }
            
            // Otherwise, increase bit count and try again
            bits += 1
        }
        
        // Technically, we never reach here because the loop will always return a value.
        0
    }
}
