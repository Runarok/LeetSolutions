import java.util.*;

class Solution {
    public List<String> braceExpansionII(String expression) {
        int[] index = new int[]{0};
        Set<String> resultSet = parseExpression(expression, index);
        
        // Convert the set to a sorted list as required by the problem
        List<String> sortedList = new ArrayList<>(resultSet);
        Collections.sort(sortedList);
        return sortedList;
    }

    /**
     * Parses an expression until it hits a closing brace '}' or the end of the string.
     * Evaluates union (',') and implicit concatenation operations.
     */
    private Set<String> parseExpression(String expr, int[] index) {
        // Union set accumulates the results separated by commas ','
        Set<String> totalUnion = new HashSet<>();
        
        // Current concatenated term set (resets after encountering a comma)
        Set<String> currentTerm = new HashSet<>();
        currentTerm.add(""); // Base seed for string concatenation

        while (index[0] < expr.length()) {
            char c = expr.charAt(index[0]);

            if (c == '{') {
                // Skip '{' and evaluate the inner nested expression recursively
                index[0]++;
                Set<String> nestedSet = parseExpression(expr, index);
                
                // Concatenate current term elements with nested set elements
                currentTerm = combine(currentTerm, nestedSet);
            } else if (c == '}') {
                // End of current inner scope: stop loop and advance past '}'
                index[0]++;
                break;
            } else if (c == ',') {
                // Comma acts as an addition operator: store current term into total union
                totalUnion.addAll(currentTerm);
                
                // Reset current term for the next segment after comma
                currentTerm = new HashSet<>();
                currentTerm.add("");
                
                index[0]++;
            } else {
                // Single letter x: represent as singleton {"x"} and concatenate
                Set<String> letterSet = new HashSet<>();
                letterSet.add(String.valueOf(c));
                
                currentTerm = combine(currentTerm, letterSet);
                index[0]++;
            }
        }

        // Add the last accumulated term into the total union set
        totalUnion.addAll(currentTerm);
        return totalUnion;
    }

    /**
     * Helper function to perform Cartesian product concatenation between two sets of strings.
     * e.g., combine({"a", "b"}, {"c", "d"}) -> {"ac", "ad", "bc", "bd"}
     */
    private Set<String> combine(Set<String> set1, Set<String> set2) {
        Set<String> result = new HashSet<>();
        for (String s1 : set1) {
            for (String s2 : set2) {
                result.add(s1 + s2);
            }
        }
        return result;
    }
}