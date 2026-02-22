class Solution {
    fun binaryGap(n: Int): Int {
        // Convert the number to its binary string representation
        val binary = n.toString(2)
        
        // Store the index of the last seen '1'
        var last = -1
        
        // Store the maximum distance found
        var max = 0
        
        // Iterate through each character in the binary string
        for (i in binary.indices) {
            // If the current bit is '1'
            if (binary[i] == '1') {
                
                // If we have seen a previous '1', calculate the distance
                if (last != -1) {
                    max = maxOf(max, i - last)
                }
                
                // Update the last seen position of '1'
                last = i
            }
        }
        
        // Return the maximum distance found
        return max
    }
}