public class Solution {
    /// <summary>
    /// Determines whether a string containing '(', ')', and '*' is valid.
    /// Uses a Greedy Approach tracking the range of possible open bracket counts.
    /// 
    /// Time Complexity: O(N) - single pass through the string of length N.
    /// Space Complexity: O(1) - only two integer variables are used.
    /// </summary>
    /// <param name="s">The input string containing '(', ')', and '*'</param>
    /// <returns>True if the string can form a valid parenthesis sequence; false otherwise.</returns>
    public bool CheckValidString(string s) {
        // 'low' represents the minimum possible number of unmatched '('
        // 'high' represents the maximum possible number of unmatched '('
        int low = 0;
        int high = 0;

        foreach (char c in s) {
            if (c == '(') {
                // '(' increases both the min and max possible open counts
                low++;
                high++;
            } 
            else if (c == ')') {
                // ')' decreases both the min and max possible open counts
                low--;
                high--;
            } 
            else { // c == '*'
                // '*' can be treated as:
                // 1. ')' -> decreases open count (low--)
                // 2. '(' -> increases open count (high++)
                // 3. ""  -> keeps open count the same (no change)
                low--;
                high++;
            }

            // 'high' falling below 0 means even if all '*' were treated as '(',
            // we have more closing parentheses ')' than open ones.
            // This makes the string invalid immediately.
            if (high < 0) {
                return false;
            }

            // 'low' cannot be negative because we cannot have fewer than 0 open brackets.
            // If low < 0, it means some '*' were assumed to be ')' when they didn't need to be.
            // Reset 'low' to 0 to represent the valid lower bound.
            if (low < 0) {
                low = 0;
            }
        }

        // If 'low' is 0, it means we can successfully balance all brackets.
        return low == 0;
    }
}