class Solution {
  List<String> restoreIpAddresses(String s) {
    List<String> result = [];

    // Helper function to check if a segment is a valid IP section
    bool isValid(String segment) {
      // Segment length 0 is invalid
      if (segment.isEmpty) return false;
      // Leading zeros are invalid, except for "0"
      if (segment.length > 1 && segment.startsWith('0')) return false;
      // Must be <= 255
      int value = int.parse(segment);
      return value >= 0 && value <= 255;
    }

    // Backtracking function
    void backtrack(int start, List<String> path) {
      // If we have 4 segments and reached the end of string, it's valid
      if (path.length == 4) {
        if (start == s.length) {
          result.add(path.join('.')); // Join segments with dots
        }
        return;
      }

      // Try all possible segment lengths (1 to 3)
      for (int len = 1; len <= 3; len++) {
        // Avoid going out of bounds
        if (start + len > s.length) break;

        String segment = s.substring(start, start + len);

        if (isValid(segment)) {
          path.add(segment);           // Choose this segment
          backtrack(start + len, path); // Recurse for next part
          path.removeLast();            // Backtrack
        }
      }
    }

    backtrack(0, []);
    return result;
  }
}
