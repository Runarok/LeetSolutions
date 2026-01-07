class Solution {
  String getHappyString(int n, int k) {
    List<String> result = [];
    List<String> letters = ['a', 'b', 'c'];

    // Backtracking function to build happy strings
    void backtrack(String current) {
      // If we already have k strings, stop early
      if (result.length >= k) return;

      // If the current string reaches length n, add it to result
      if (current.length == n) {
        result.add(current);
        return;
      }

      for (String ch in letters) {
        // Skip if same as previous character (to maintain happy string)
        if (current.isNotEmpty && current[current.length - 1] == ch) continue;

        backtrack(current + ch); // Recurse with new character
      }
    }

    backtrack(''); // Start with empty string

    // Return k-th string if it exists, else empty string
    return k <= result.length ? result[k - 1] : '';
  }
}
