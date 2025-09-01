class Solution {
    fun vowelStrings(words: Array<String>, queries: Array<IntArray>): IntArray {
        // Define the set of vowels for easy lookup
        val vowels = setOf('a', 'e', 'i', 'o', 'u')

        // Helper function to check if a string starts and ends with a vowel
        fun isVowelString(s: String): Boolean {
            // Check if string is not empty and
            // both the first and last characters are vowels
            return s.isNotEmpty() && s.first() in vowels && s.last() in vowels
        }

        val n = words.size
        // Create a prefix sum array where prefix[i] will store the count
        // of strings starting and ending with a vowel in words[0..i-1]
        val prefix = IntArray(n + 1)

        // Build the prefix sum array
        for (i in 0 until n) {
            // If current word is a vowel-string, add 1 to the prefix count,
            // otherwise just carry forward the previous count
            prefix[i + 1] = prefix[i] + if (isVowelString(words[i])) 1 else 0
        }

        // Result array to store answers for each query
        val result = IntArray(queries.size)

        // Process each query
        for (i in queries.indices) {
            val (l, r) = queries[i]
            // Use prefix sums to calculate count in O(1):
            // number of vowel-strings in words[l..r] = prefix[r+1] - prefix[l]
            result[i] = prefix[r + 1] - prefix[l]
        }

        // Return the answers for all queries
        return result
    }
}
