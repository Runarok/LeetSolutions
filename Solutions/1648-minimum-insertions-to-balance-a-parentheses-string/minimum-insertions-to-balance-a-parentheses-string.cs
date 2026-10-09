public class Solution {
    public int MinInsertions(string s) {

        // 'open' keeps track of how many '(' characters
        // still need their two consecutive ')' characters.
        int open = 0;

        // 'insertions' counts the minimum number of characters
        // we need to insert to make the string balanced.
        int insertions = 0;

        // Process every character in the string from left to right.
        for (int i = 0; i < s.Length; i++) {

            // CASE 1: We encounter an opening parenthesis '('.
            if (s[i] == '(') {

                // Every '(' requires exactly two consecutive ')'
                // characters to close it.
                open++;

                // CASE 2: We encounter a closing parenthesis ')'.
            } else {

                // Check whether the current ')' is followed by
                // another ')' to form the required closing pair.
                if (i + 1 < s.Length && s[i + 1] == ')') {

                    // We found a valid pair '))'.
                    // Skip the next ')' because it is already
                    // part of this closing pair.
                    i++;

                } else {

                    // The current ')' does not have another ')'
                    // immediately after it.
                    // Insert one ')' to complete the pair.
                    insertions++;
                }

                // Now we have processed one complete closing pair '))'.
                // It must match an opening '('.

                if (open > 0) {

                    // There is an unmatched '(' available.
                    // Match this closing pair with that '('.
                    open--;

                } else {

                    // There is no opening '(' for this closing pair.
                    // Insert one '(' before the closing pair.
                    insertions++;
                }
            }
        }

        // Every remaining '(' needs two ')' characters.
        // Each unmatched opening parenthesis therefore requires
        // two additional insertions.
        insertions += open * 2;

        // Return the minimum number of insertions required.
        return insertions;
    }
}