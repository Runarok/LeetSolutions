class Solution {
    public String digitSum(String s, int k) {
        // Continue performing rounds as long as the length of s is strictly greater than k
        while (s.length() > k) {
            // StringBuilder to efficiently construct the new string for the current round
            StringBuilder newString = new StringBuilder();
            
            // Step 1: Iterate through the string in consecutive chunks (groups) of size k
            for (int i = 0; i < s.length(); i += k) {
                // Determine the end index of the current group, handling the last group which may be smaller than k
                int end = Math.min(i + k, s.length());
                String group = s.substring(i, end);
                
                // Step 2: Calculate the sum of all digits in the current group
                int sum = 0;
                for (int j = 0; j < group.length(); j++) {
                    // Convert character digit to its integer value (e.g., '3' -> 3) and add to sum
                    sum += group.charAt(j) - '0';
                }
                
                // Step 3: Append the resulting digit sum as a string to our newString
                newString.append(sum);
            }
            
            // Update s to be the newly formed string for the next round (if length > k)
            s = newString.toString();
        }
        
        // Once s.length() <= k, return the final result
        return s;
    }
}