class Solution {
  // This method returns the number of times two identical characters appear consecutively.
  int possibleStringCount(String word) {
    // Get the length of the input string
    int n = word.length;

    // If the string is empty, return 0 as there are no possible pairs
    if (n == 0) return 0;

    // Initialize the answer to 1 (as in the original Go code)
    int ans = 1;

    // Loop through the string starting from the second character
    for (int i = 1; i < n; i++) {
      // If the current character is the same as the previous one,
      // increment the answer
      if (word[i - 1] == word[i]) {
        ans++;
      }
    }

    // Return the total count
    return ans;
  }
}