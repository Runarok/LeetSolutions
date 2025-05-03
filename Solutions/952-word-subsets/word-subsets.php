class Solution {

    /**
     * @param String[] $words1
     * @param String[] $words2
     * @return String[]
     */
    function wordSubsets($words1, $words2) {
        // Step 1: Build the frequency map for words2
        $maxFreq = array_fill(0, 26, 0); // array to store max frequency of each character
        
        // Loop through each word in words2
        foreach ($words2 as $word) {
            $freq = array_fill(0, 26, 0); // Frequency of characters in the current word
            foreach (str_split($word) as $char) {
                $freq[ord($char) - ord('a')]++; // Increment the frequency of the character
            }
            // Update the maxFreq map to store the max frequency required by any word in words2
            for ($i = 0; $i < 26; $i++) {
                $maxFreq[$i] = max($maxFreq[$i], $freq[$i]);
            }
        }

        // Step 2: Check each word in words1
        $result = [];
        foreach ($words1 as $word) {
            $freq = array_fill(0, 26, 0); // Frequency of characters in the current word
            foreach (str_split($word) as $char) {
                $freq[ord($char) - ord('a')]++; // Increment the frequency of the character
            }
            
            // Check if the word satisfies the universal condition
            $isUniversal = true;
            for ($i = 0; $i < 26; $i++) {
                if ($freq[$i] < $maxFreq[$i]) {
                    $isUniversal = false;
                    break;
                }
            }
            
            // If it's a universal word, add it to the result
            if ($isUniversal) {
                $result[] = $word;
            }
        }

        return $result;
    }
}
