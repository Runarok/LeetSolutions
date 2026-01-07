class Solution {
  int numberOfSubstrings(String s) {
    int n = s.length;
    int left = 0;
    int ans = 0;

    // Count of 'a', 'b', 'c' in the current window
    Map<String, int> count = {'a': 0, 'b': 0, 'c': 0};

    for (int right = 0; right < n; right++) {
      // Add the current character to the count
      count[s[right]] = count[s[right]]! + 1;

      // Shrink the window from the left if it still contains all three characters
      while (count['a']! > 0 && count['b']! > 0 && count['c']! > 0) {
        // All substrings starting at left and ending at right..n-1 are valid
        ans += n - right;

        // Remove the left character and move left forward
        count[s[left]] = count[s[left]]! - 1;
        left++;
      }
    }

    return ans;
  }
}
