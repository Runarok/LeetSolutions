class Solution {
  int maximumLengthSubstring(String s) {
    // Stores the number of times each character appears
    // in the current sliding window.
    //
    // Since the string contains only lowercase English
    // letters, we only need an array of size 26.
    final List<int> frequency = List.filled(26, 0);

    // 'left' represents the starting position of
    // our current substring/window.
    int left = 0;

    // Stores the maximum valid substring length found.
    int maxLength = 0;

    // 'right' expands the sliding window one character
    // at a time.
    for (int right = 0; right < s.length; right++) {
      // Convert the current character into an index.
      //
      // For example:
      // 'a' - 'a' = 0
      // 'b' - 'a' = 1
      // 'c' - 'a' = 2
      final int index = s.codeUnitAt(right) - 'a'.codeUnitAt(0);

      // Add the current character to the window.
      frequency[index]++;

      // If this character appears more than twice,
      // the current window is invalid.
      //
      // Move 'left' forward until the character appears
      // at most two times again.
      while (frequency[index] > 2) {
        // Remove the character at the left side
        // from our frequency count.
        final int leftIndex =
            s.codeUnitAt(left) - 'a'.codeUnitAt(0);

        frequency[leftIndex]--;

        // Shrink the window from the left.
        left++;
      }

      // The current window is now valid because every
      // character occurs at most twice.
      //
      // Window length = right - left + 1
      final int currentLength = right - left + 1;

      // Update the maximum length if this window
      // is longer than the previous answer.
      if (currentLength > maxLength) {
        maxLength = currentLength;
      }
    }

    // Return the maximum valid substring length.
    return maxLength;
  }
}