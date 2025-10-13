class Solution {
    fun removeAnagrams(words: Array<String>): List<String> {
        // Helper function to check if two words are anagrams
        fun isAnagram(s1: String, s2: String): Boolean {
            // Sort both strings and compare
            return s1.toCharArray().sorted() == s2.toCharArray().sorted()
        }

        // This will store the final result after removing anagrams
        val result = mutableListOf<String>()

        // Iterate through each word in the input array
        for (word in words) {
            // If result is not empty and the current word is an anagram
            // of the last word in result, we skip adding this word
            if (result.isNotEmpty() && isAnagram(result.last(), word)) {
                // Skip the word (i.e., do not add to result)
                continue
            } else {
                // If not an anagram, add the word to the result list
                result.add(word)
            }
        }

        // Return the final list after removing anagrams
        return result
    }
}
