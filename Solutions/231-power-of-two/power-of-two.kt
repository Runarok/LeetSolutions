class Solution {
    fun isPowerOfTwo(n: Int): Boolean {
        // Check if n is greater than 0 and has only one bit set
        return n > 0 && (n and (n - 1)) == 0
    }
}
