import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public String evaluate(String s, List<List<String>> knowledge) {
        // Step 1: Store key-value pairs from knowledge array into a HashMap for O(1) fast lookup.
        Map<String, String> map = new HashMap<>();
        for (List<String> pair : knowledge) {
            // pair.get(0) is the key, pair.get(1) is the corresponding value
            map.put(pair.get(0), pair.get(1));
        }

        // StringBuilder to efficiently construct the final output string.
        StringBuilder result = new StringBuilder();
        
        // StringBuilder to build the current key inside brackets.
        StringBuilder currentKey = new StringBuilder();
        
        // Boolean flag to track whether we are currently parsing inside brackets '(' and ')'.
        boolean insideBracket = false;

        // Step 2: Traverse through each character in the given string s.
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);

            if (ch == '(') {
                // Open bracket detected: Start accumulating key characters.
                insideBracket = true;
            } else if (ch == ')') {
                // Close bracket detected: Finish reading key and process evaluation.
                insideBracket = false;
                String key = currentKey.toString();
                
                // If key exists in HashMap, append its value; otherwise, append "?".
                result.append(map.getOrDefault(key, "?"));
                
                // Clear the currentKey buffer for future bracket pairs.
                currentKey.setLength(0);
            } else {
                // If inside brackets, append character to currentKey buffer.
                // Otherwise, append character directly to result.
                if (insideBracket) {
                    currentKey.append(ch);
                } else {
                    result.append(ch);
                }
            }
        }

        // Step 3: Return the fully evaluated string.
        return result.toString();
    }
}