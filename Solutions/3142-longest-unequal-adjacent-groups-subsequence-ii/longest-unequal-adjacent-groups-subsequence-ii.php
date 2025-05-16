class Solution {

    /**
     * Main function to find the longest subsequence that meets the given conditions
     * 
     * @param String[] $words - Array of words
     * @param Integer[] $groups - Array of group indices corresponding to the words
     * @return String[] - The longest subsequence of words that satisfy the conditions
     */
    function getWordsInLongestSubsequence($words, $groups) {
        // n is the number of words in the input array
        $n = count($words);

        // Initialize dp array where dp[i] will store the length of the longest subsequence
        // that ends at index i. Initially, each word can be a subsequence of length 1.
        $dp = array_fill(0, $n, 1);

        // Initialize prev array to track the previous word's index in the subsequence
        // This will help us backtrack and reconstruct the final subsequence.
        $prev = array_fill(0, $n, -1);

        // To track the index of the word that is part of the longest subsequence
        $maxIndex = 0;

        // Start filling dp and prev arrays
        // i is the current word we are considering to be added to a subsequence
        for ($i = 1; $i < $n; $i++) {
            // j is the previous word we are comparing with the current word at index i
            for ($j = 0; $j < $i; $j++) {
                // Check if the two words (i and j) satisfy the following conditions:
                // 1. They must belong to different groups.
                // 2. Their Hamming distance must be exactly 1 (they differ by exactly one character).
                if ($this->check($words[$i], $words[$j]) && $dp[$j] + 1 > $dp[$i] && $groups[$i] !== $groups[$j]) {
                    // If both conditions are met, we update dp[i] (longest subsequence ending at i)
                    // by extending the subsequence that ends at j.
                    $dp[$i] = $dp[$j] + 1;
                    // Update the prev array to record that we are extending the subsequence from word j.
                    $prev[$i] = $j;
                }
            }
            // If we find that the subsequence ending at i is the longest so far, update maxIndex
            if ($dp[$i] > $dp[$maxIndex]) {
                $maxIndex = $i;
            }
        }

        // Reconstruct the longest subsequence starting from maxIndex
        // We backtrack using the prev array to get the correct order of words in the subsequence
        $result = [];
        for ($i = $maxIndex; $i >= 0; $i = $prev[$i]) {
            // Add words to the result array (we use array_unshift to add at the beginning)
            array_unshift($result, $words[$i]);
        }

        // Return the reconstructed subsequence
        return $result;
    }

    /**
     * Helper function to check if two words have a Hamming distance of exactly 1
     * 
     * @param String $s1 - The first word
     * @param String $s2 - The second word
     * @return bool - Returns true if the Hamming distance between the two words is exactly 1
     */
    private function check($s1, $s2) {
        // If the words have different lengths, their Hamming distance can't be 1.
        if (strlen($s1) !== strlen($s2)) {
            return false;
        }

        // Count how many characters differ between the two words
        $diff = 0;
        for ($i = 0; $i < strlen($s1); $i++) {
            if ($s1[$i] !== $s2[$i]) {
                // If more than one character differs, the Hamming distance is not 1
                if (++$diff > 1) {
                    return false;
                }
            }
        }

        // If exactly one character differs, the Hamming distance is 1
        return $diff === 1;
    }
}
