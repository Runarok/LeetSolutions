class Solution {
  int sumScores(String s) {
    int n = s.length;
    List<int> z = List.filled(n, 0);

    int left = 0, right = 0;

    for (int i = 1; i < n; i++) {
      if (i <= right) {
        // i is inside the current Z-box
        z[i] = (right - i + 1).clamp(0, z[i - left]);
      }

      // Try to extend Z-box from position i
      while (i + z[i] < n && s[z[i]] == s[i + z[i]]) {
        z[i]++;
      }

      // Update the Z-box
      if (i + z[i] - 1 > right) {
        left = i;
        right = i + z[i] - 1;
      }
    }

    // The score of s1 is n itself (whole string matches itself)
    int total = n + z.reduce((a, b) => a + b);
    return total;
  }
}
