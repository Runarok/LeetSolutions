class Solution {
    fun countPrimeSetBits(left: Int, right: Int): Int {
        
        // ---------------------------------------------------------
        // We only need to check prime numbers up to 20.
        //
        // Why 20?
        // The maximum value of right is 10^6.
        // 10^6 in binary fits within 20 bits (since 2^20 = 1,048,576).
        //
        // So the maximum possible number of set bits for any number
        // in the range is 20.
        // ---------------------------------------------------------
        
        // Precompute all prime numbers up to 20.
        // These are the only possible prime set-bit counts.
        val primeSet = setOf(
            2, 3, 5, 7, 11, 13, 17, 19
        )
        
        // This will store how many numbers in the range
        // have a prime number of set bits.
        var count = 0
        
        // ---------------------------------------------------------
        // Iterate through every number in the inclusive range
        // from left to right.
        // ---------------------------------------------------------
        for (num in left..right) {
            
            // -----------------------------------------------------
            // Count how many 1s are in the binary representation.
            //
            // Kotlin provides a built-in function:
            // Integer.bitCount(num)
            //
            // It returns the number of set bits (1s).
            // -----------------------------------------------------
            val setBits = Integer.bitCount(num)
            
            // -----------------------------------------------------
            // If the number of set bits is prime,
            // increase our counter.
            // -----------------------------------------------------
            if (setBits in primeSet) {
                count++
            }
        }
        
        // Return the total count.
        return count
    }
}