class Solution {

    /**
     * @param String[] $words
     * @return Integer
     */
    function longestPalindrome($words) {
        // Count occurrences of each word
        $count = [];
        foreach ($words as $word) {
            if (!isset($count[$word])) {
                $count[$word] = 0;
            }
            $count[$word]++;
        }

        $length = 0;          // Length of the palindrome
        $usedMiddle = false;  // Flag to track if we've used a middle palindrome word

        foreach ($count as $word => $freq) {
            $reverse = strrev($word);

            // Case 1: Word is a palindrome itself (e.g., "gg")
            if ($word === $reverse) {
                // We can use pairs of these words symmetrically
                // Each pair adds 4 characters (2 + 2)
                $pairs = intdiv($freq, 2);
                $length += $pairs * 4;

                // If there is an odd count leftover, we can place one in the middle once
                if (!$usedMiddle && $freq % 2 == 1) {
                    $length += 2;
                    $usedMiddle = true;
                }
            }
            // Case 2: Word is not palindrome (e.g., "ab")
            // To avoid double counting, only count when word < reverse lex order
            elseif ($word < $reverse && isset($count[$reverse])) {
                // Take min pairs from word and reverse
                $pairs = min($freq, $count[$reverse]);
                $length += $pairs * 4; // Each pair contributes 4 chars
            }
        }

        return $length;
    }
}
