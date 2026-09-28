class Solution {
    public int maxDepth(String s) {
        // Track the current depth of open parentheses
        int currentDepth = 0;
        
        // Track the maximum depth encountered so far
        int maxDepth = 0;

        // Iterate through each character in the string
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);

            // Increment current depth when entering a nested parenthesis level
            if (ch == '(') {
                currentDepth++;
                // Update maxDepth if current depth exceeds the record
                if (currentDepth > maxDepth) {
                    maxDepth = currentDepth;
                }
            } 
            // Decrement current depth when exiting a parenthesis level
            else if (ch == ')') {
                currentDepth--;
            }
        }

        // Return the highest nesting depth found
        return maxDepth;
    }
}