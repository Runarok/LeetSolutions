public class Solution {
    public string RemoveOuterParentheses(string s) {
        // StringBuilder is used for efficient string manipulation in O(1) amortized time per append.
        System.Text.StringBuilder result = new System.Text.StringBuilder();

        // 'opened' keeps track of the depth of open parentheses in the current primitive component.
        // - opened == 0 indicates we are at the outermost '(' of a primitive string.
        // - opened == 1 (after decrement) indicates we are at the outermost ')' of a primitive string.
        int opened = 0;

        // Iterate through each character in the input string.
        foreach (char c in s) {
            if (c == '(') {
                // If 'opened' is greater than 0, this '(' is NOT the outermost open parenthesis
                // of a primitive string, so we append it to our result.
                if (opened > 0) {
                    result.Append(c);
                }
                
                // Increment depth counter for every '(' encountered.
                opened++;
            } 
            else { // c == ')'
                // Decrement depth counter first to reflect closing the current level.
                opened--;

                // If 'opened' is still greater than 0, this ')' is NOT the outermost close parenthesis
                // of a primitive string, so we append it to our result.
                if (opened > 0) {
                    result.Append(c);
                }
            }
        }

        // Convert the accumulated characters back into a string.
        return result.ToString();
    }
}