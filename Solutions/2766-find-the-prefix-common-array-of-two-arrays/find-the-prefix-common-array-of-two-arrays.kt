class Solution {

    fun findThePrefixCommonArray(A: IntArray, B: IntArray): IntArray {

        // Size of arrays
        val n = A.size

        // Answer array
        val result = IntArray(n)

        // Track visited numbers
        // Since numbers are from 1 to n
        val seen = IntArray(n + 1)

        // Current common count
        var common = 0

        // Traverse both arrays
        for (i in 0 until n) {

            // Mark element from A
            seen[A[i]]++

            // If count becomes 2,
            // it means the number appeared
            // in both A and B prefixes
            if (seen[A[i]] == 2) {
                common++
            }

            // Mark element from B
            seen[B[i]]++

            // Again check if it became common
            if (seen[B[i]] == 2) {
                common++
            }

            // Store answer for current prefix
            result[i] = common
        }

        // Return final array
        return result
    }
}