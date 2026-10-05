public class Solution {
    public int ScoreOfParentheses(string s) {
        // APPROACH 1: Counting Core Depth (Optimal: O(N) Time, O(1) Space)
        // ---------------------------------------------------------------
        // Every "()" pair contributes 2^depth to the total score, where depth 
        // is the number of currently open unmatched '(' before this pair.
        // Nested outer parentheses (A) multiply the inner score by 2, which is
        // equivalent to left-shifting 1 by the depth level: 1 << depth.

        int score = 0; // Tracks the total cumulative score
        int depth = 0; // Tracks the current nesting level / depth of parentheses

        for (int i = 0; i < s.Length; i++) {
            if (s[i] == '(') {
                // Entering a deeper nesting level
                depth++;
            } else {
                // Exiting a nesting level
                depth--;

                // Check if s[i] forms a primitive base pair "()" with s[i - 1]
                if (s[i - 1] == '(') {
                    // "()" found at current depth.
                    // The base score 1 is multiplied by 2^depth (represented as 1 << depth).
                    score += 1 << depth;
                }
            }
        }

        return score;
    }
}