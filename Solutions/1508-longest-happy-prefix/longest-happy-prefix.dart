class Solution {
  String longestPrefix(String s) {
    int n = s.length;
    if (n == 0) return "";

    // LPS array for KMP
    List<int> lps = List.filled(n, 0);

    int length = 0; // length of previous longest prefix-suffix

    // start from index 1
    for (int i = 1; i < n; i++) {
      // If mismatch, reduce length to previous LPS
      while (length > 0 && s[i] != s[length]) {
        length = lps[length - 1];
      }

      // If match, increase length
      if (s[i] == s[length]) {
        length++;
      }

      // Set LPS for i
      lps[i] = length;
    }

    // The last value in LPS is the length of longest happy prefix
    return s.substring(0, lps[n - 1]);
  }
}
