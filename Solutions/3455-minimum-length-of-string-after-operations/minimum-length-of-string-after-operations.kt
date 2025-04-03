class Solution {
    fun minimumLength(s: String): Int {
        // Step 1: Count the frequency of each character in the string
        val charFrequencyMap = mutableMapOf<Char, Int>()
        for (char in s) {
            // Increment the count for the current character
            charFrequencyMap[char] = charFrequencyMap.getOrDefault(char, 0) + 1
        }

        // Step 2: Calculate the number of characters to delete
        var deleteCount = 0
        for (frequency in charFrequencyMap.values) {
            if (frequency % 2 == 1) {
                // If the frequency of a character is odd, we can delete all except one
                deleteCount += frequency - 1
            } else {
                // If the frequency is even, we can delete all except two
                deleteCount += frequency - 2
            }
        }

        // Step 3: Return the minimum length after deletions
        // Subtract the total number of characters deleted from the original length
        return s.length - deleteCount
    }
}
