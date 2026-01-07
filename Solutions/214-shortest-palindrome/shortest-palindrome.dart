class Solution {
  String shortestPalindrome(String s) {
    if (s.isEmpty) return s;

    // Step 1: Reverse the string
    String rev = s.split('').reversed.join();

    // Step 2: Concatenate original + '#' + reversed string
    String combined = s + '#' + rev;

    // Step 3: Build the LPS array for the combined string
    List<int> lps = List.filled(combined.length, 0);

    for (int i = 1; i < combined.length; i++) {
      int length = lps[i - 1];

      // Match the prefix and suffix
      while (length > 0 && combined[i] != combined[length]) {
        length = lps[length - 1];
      }

      if (combined[i] == combined[length]) {
        length++;
      }

      lps[i] = length;
    }

    // Step 4: The last value in LPS gives the length of palindromic prefix
    int palPrefixLen = lps.last;

    // Step 5: Take the remaining suffix, reverse it, and prepend
    String suffix = s.substring(palPrefixLen);
    String prefixToAdd = suffix.split('').reversed.join();

    return prefixToAdd + s;
  }
}
