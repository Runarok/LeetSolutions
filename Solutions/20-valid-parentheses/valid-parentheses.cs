public class Solution {
    public bool IsValid(string s) {
        // QUICK OPTIMIZATION:
        // A valid string of balanced parentheses must have an even length.
        // If the length is odd, it's impossible to match every bracket.
        if (s.Length % 2 != 0) {
            return false;
        }

        // Initialize a stack to keep track of expected closing brackets.
        // Using Stack<char> in C# provides O(1) Push, Pop, and Peek operations.
        Stack<char> expectedBrackets = new Stack<char>();

        // Loop through each character in the input string s.
        foreach (char c in s) {
            // CASE 1: Opening Brackets
            // For each opening bracket, push the EXACT closing bracket we expect to see later.
            if (c == '(') {
                expectedBrackets.Push(')');
            } 
            else if (c == '{') {
                expectedBrackets.Push('}');
            } 
            else if (c == '[') {
                expectedBrackets.Push(']');
            } 
            // CASE 2: Closing Brackets
            else {
                // SUB-CASE 2A: The stack is empty.
                // This means we encountered a closing bracket without a preceding opening bracket.
                // Example: s = "]" or s = "()" followed by "]" -> "()]"
                if (expectedBrackets.Count == 0) {
                    return false;
                }

                // SUB-CASE 2B: The popped bracket does NOT match current character.
                // Since Stack is LIFO, Pop() gives us the most recently required closing bracket.
                // Example mismatch: s = "(]" -> Push(')'), encounter ']', Pop() yields ')', ')' != ']'
                if (expectedBrackets.Pop() != c) {
                    return false;
                }
            }
        }

        // FINAL CHECK:
        // If expectedBrackets is empty, all opening brackets were correctly closed.
        // If count > 0, there are unclosed opening brackets left over.
        // Example unclosed: s = "((" -> Stack still contains two ')' characters.
        return expectedBrackets.Count == 0;
    }
}