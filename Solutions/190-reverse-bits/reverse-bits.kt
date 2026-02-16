class Solution {
    // Reverse bits of a 32-bit unsigned integer
    fun reverseBits(n: Int): Int {
        var result = 0  // This will store the reversed bit result
        
        // Loop through all 32 bits (since Int is 32-bit)
        for (i in 0..31) {
            
            // Shift result left to make space for the next bit
            result = result shl 1
            
            // Extract the i-th bit from n
            // (n shr i) moves the i-th bit to the least significant position
            // 'and 1' keeps only that last bit (0 or 1)
            val bit = (n shr i) and 1
            
            // Add the extracted bit to result
            result = result or bit
        }
        
        // Return the final reversed bit number
        return result
    }
}
