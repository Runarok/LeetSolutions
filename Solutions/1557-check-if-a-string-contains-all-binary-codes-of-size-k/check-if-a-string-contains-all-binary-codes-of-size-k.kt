class Solution {

    fun hasAllCodes(s: String, k: Int): Boolean {

        // If the string length is smaller than k,
        // it is impossible to contain all binary substrings of length k
        if (s.length < k) return false

        // Total number of possible binary codes of length k
        // For example:
        // k = 2 -> 2^2 = 4 codes -> 00, 01, 10, 11
        // k = 3 -> 2^3 = 8 codes
        val needed = 1 shl k   // same as 2^k

        // Boolean array to track which codes we have seen
        // Index represents the integer value of the binary substring
        // Example:
        // "00" -> 0
        // "01" -> 1
        // "10" -> 2
        // "11" -> 3
        val seen = BooleanArray(needed)

        // Count how many unique binary codes we have found so far
        var count = 0

        // This will store the rolling integer value of current window
        var hash = 0

        // Iterate over each character in the string
        for (i in s.indices) {

            // Left shift hash by 1 (multiply by 2)
            // Then add current bit (0 or 1)
            // Example:
            // if hash = 2 (10 in binary)
            // shift left -> 100 (4)
            // add new bit
            hash = (hash shl 1) or (s[i] - '0')

            // We only want the last k bits
            // So we remove extra bits using bitmask
            // (needed - 1) gives a mask like:
            // if k = 3 -> needed = 8 -> mask = 7 -> 111 (binary)
            hash = hash and (needed - 1)

            // Start checking only when we have at least k characters processed
            if (i >= k - 1) {

                // If we haven't seen this binary code before
                if (!seen[hash]) {

                    // Mark it as seen
                    seen[hash] = true

                    // Increase count of unique codes found
                    count++

                    // If we found all possible codes, return true immediately
                    if (count == needed) {
                        return true
                    }
                }
            }
        }

        // If we exit loop without finding all codes
        // then at least one binary substring of length k is missing
        return false
    }
}