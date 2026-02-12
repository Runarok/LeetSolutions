class Solution {

    // This method finds the length of the longest substring
    // where all characters that appear in the substring
    // appear the SAME number of times.
    public int longestBalanced(String s) {

        // Length of the input string
        int n = s.length();

        // Variable to store the maximum balanced substring length found
        int maxL = 0;

        // Outer loop: choose the starting index of substring
        for (int i = 0; i < n; i++) {

            // Frequency array to count occurrences of characters
            // Only lowercase English letters (a-z), so size = 26
            int[] arr = new int[26];

            // Inner loop: choose the ending index of substring
            for (int j = i; j < n; j++) {

                // Current character at position j
                char ch = s.charAt(j);

                // Increase frequency of this character
                arr[ch - 'a'] += 1;

                // Check if current substring s[i...j] is balanced
                if (checkBalanced(arr)) {

                    // Update max length if current substring is larger
                    maxL = Math.max(maxL, (j - i + 1));
                }
            }
        }

        // Return the maximum balanced substring length found
        return maxL;
    }

    // Helper method to check if all non-zero character frequencies
    // in the array are equal
    private boolean checkBalanced(int[] arr) {

        // This will store the frequency that all characters must match
        int common = 0;

        // Traverse all 26 letters
        for (int i = 0; i < 26; i++) {

            // Skip characters that do not appear in substring
            if (arr[i] == 0) continue;

            // If this is the first character we encounter,
            // set its frequency as the reference
            if (common == 0) {
                common = arr[i];
            }

            // If any other character has different frequency,
            // substring is not balanced
            else if (arr[i] != common) {
                return false;
            }
        }

        // If all non-zero frequencies are equal,
        // substring is balanced
        return true;
    }
}
