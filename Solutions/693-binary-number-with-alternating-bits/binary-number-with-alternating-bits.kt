class Solution {
    fun hasAlternatingBits(n: Int): Boolean {
        // XOR the number with itself shifted right by 1 bit
        // If bits alternate, this will produce a number with all bits = 1
        val x = n xor (n shr 1)
        
        // Check if x is a sequence of all 1s
        // A number with all 1s has the property: x & (x + 1) == 0
        return (x and (x + 1)) == 0
    }
}
