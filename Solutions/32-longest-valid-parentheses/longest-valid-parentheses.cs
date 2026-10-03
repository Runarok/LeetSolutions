public class Solution {
    public int LongestValidParentheses(string s) {
        // Handle edge cases: null or strings with fewer than 2 characters
        if (string.IsNullOrEmpty(s) || s.Length < 2) {
            return 0;
        }

        int maxLength = 0;
        
        // Stack stores the indices of the characters.
        // We initialize it with -1 to serve as a base boundary for valid substrings 
        // starting at index 0.
        Stack<int> stack = new Stack<int>();
        stack.Push(-1);

        for (int i = 0; i < s.Length; i++) {
            if (s[i] == '(') {
                // Push the index of the opening parenthesis onto the stack.
                stack.Push(i);
            } else {
                // Pop the last unmatched '(' or boundary index.
                stack.Pop();

                if (stack.Count == 0) {
                    // If stack is empty, this ')' is unmatched and sets a new boundary base index.
                    stack.Push(i);
                } else {
                    // Calculate the length of the valid substring ending at current index 'i'.
                    // stack.Peek() gives the index preceding the start of the valid substring.
                    int currentLength = i - stack.Peek();
                    maxLength = Math.Max(maxLength, currentLength);
                }
            }
        }

        return maxLength;
    }
}