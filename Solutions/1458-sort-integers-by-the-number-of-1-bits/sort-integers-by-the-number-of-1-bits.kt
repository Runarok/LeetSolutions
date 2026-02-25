class Solution {
    fun sortByBits(arr: IntArray): IntArray {
        
        // We use sortedWith() because we need custom sorting logic.
        // The default sort only sorts numbers in ascending order,
        // but here we must:
        //   1) Sort by number of 1-bits in binary representation
        //   2) If tie → sort by numeric value
        
        return arr.sortedWith(
            
            // compareBy allows multiple sorting conditions (keys)
            compareBy(
                
                // First sorting condition:
                // Count how many 1's exist in the binary form of the number.
                // Example:
                // 3  -> 11  -> 2 ones
                // 4  -> 100 -> 1 one
                // So 4 should come before 3.
                { number -> number.countOneBits() },
                
                // Second sorting condition (tie-breaker):
                // If two numbers have the same number of 1-bits,
                // sort them by their actual integer value.
                // Example:
                // 3 (11) and 5 (101) both have 2 ones.
                // Since 3 < 5, 3 comes first.
                { number -> number }
            )
            
        ).toIntArray() // Convert the sorted List<Int> back to IntArray
    }
}