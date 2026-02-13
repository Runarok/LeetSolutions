import java.util.*;

public class Solution {

    // Main method that computes the longest "balanced" substring.
    // A balanced substring can be:
    // 1) Only one character repeated (a, b, or c)
    // 2) Two characters appearing equal number of times (without the third)
    // 3) All three characters appearing equal number of times
    public int longestBalanced(String s) {
        int maxLen = 0;

        // Case 1: Longest single-character substring
        maxLen = Math.max(maxLen, getMaxSingle(s, 'a'));
        maxLen = Math.max(maxLen, getMaxSingle(s, 'b'));
        maxLen = Math.max(maxLen, getMaxSingle(s, 'c'));

        // Case 2: Longest substring where two characters are balanced
        // and the third character is not allowed
        maxLen = Math.max(maxLen, getMaxDouble(s, 'a', 'b', 'c'));
        maxLen = Math.max(maxLen, getMaxDouble(s, 'a', 'c', 'b'));
        maxLen = Math.max(maxLen, getMaxDouble(s, 'b', 'c', 'a'));

        // Case 3: Longest substring where a, b, c all appear equal times
        maxLen = Math.max(maxLen, getMaxTriple(s));

        return maxLen;
    }

    // --------------------------------------------
    // Case 1: Longest contiguous substring of only one character
    // --------------------------------------------
    private int getMaxSingle(String s, char target) {
        int max = 0;        // Stores maximum length found
        int current = 0;    // Current streak length
        int n = s.length();

        for (int i = 0; i < n; i++) {
            // If current character matches target, increase streak
            if (s.charAt(i) == target) {
                current++;
            } else {
                // Otherwise reset streak
                current = 0;
            }

            // Update max length
            max = Math.max(max, current);
        }

        return max;
    }

    // --------------------------------------------
    // Case 2: Longest substring where:
    // - Count(c1) == Count(c2)
    // - 'forbidden' character must not appear
    //
    // Uses prefix difference technique:
    // diff = count(c1) - count(c2)
    // If same diff seen before → substring in between is balanced.
    // --------------------------------------------
    private int getMaxDouble(String s, char c1, char c2, char forbidden) {
        int n = s.length();
        int max = 0;

        int diff = 0;  // Difference between counts of c1 and c2

        // Arrays used to simulate a HashMap for better performance
        // firstSeen[index] = first index where this diff was seen
        // version[index] = used to reset efficiently when forbidden appears
        int[] firstSeen = new int[2 * n + 1];
        int[] version = new int[2 * n + 1];
        int curVersion = 1;

        // diff = 0 initially (balanced before starting)
        firstSeen[n] = -1;
        version[n] = 1;

        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);

            // If forbidden character appears:
            // Reset everything (start new segment)
            if (c == forbidden) {
                curVersion++;   // Increment version instead of clearing arrays
                diff = 0;       // Reset difference

                // Mark diff=0 as seen at current index
                version[n] = curVersion;
                firstSeen[n] = i;
            } else {
                // Update difference
                if (c == c1) {
                    diff++;
                } else if (c == c2) {
                    diff--;
                }

                // Shift index by n to handle negative diff
                int index = diff + n;

                if (version[index] == curVersion) {
                    // If same diff seen before in this segment,
                    // substring between is balanced
                    max = Math.max(max, i - firstSeen[index]);
                } else {
                    // First time seeing this diff in this segment
                    firstSeen[index] = i;
                    version[index] = curVersion;
                }
            }
        }

        return max;
    }

    // --------------------------------------------
    // Case 3: Longest substring where:
    // count(a) == count(b) == count(c)
    //
    // Use two differences:
    // diff1 = count(a) - count(b)
    // diff2 = count(b) - count(c)
    //
    // If (diff1, diff2) repeats → substring in between is balanced.
    // --------------------------------------------
    private int getMaxTriple(String s) {
        int n = s.length();
        int max = 0;

        int diff1 = 0;  // count(a) - count(b)
        int diff2 = 0;  // count(b) - count(c)

        // Map storing first index where a (diff1, diff2) pair appears
        Map<Long, Integer> firstSeen = new HashMap<>();

        // Initially both diffs are 0 at index -1
        long initialKey = 0L;
        firstSeen.put(initialKey, -1);

        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);

            // Update difference counters
            if (c == 'a') {
                diff1++;
            } 
            else if (c == 'b') {
                diff1--; 
                diff2++;
            } 
            else if (c == 'c') {
                diff2--;
            }

            // Combine two ints into one long key
            // Upper 32 bits = diff1
            // Lower 32 bits = diff2
            long key = (((long) diff1) << 32) | (diff2 & 0xFFFFFFFFL);

            if (firstSeen.containsKey(key)) {
                // If we've seen this (diff1, diff2) before,
                // substring between is balanced
                max = Math.max(max, i - firstSeen.get(key));
            } else {
                // First time seeing this pair
                firstSeen.put(key, i);
            }
        }

        return max;
    }
}
