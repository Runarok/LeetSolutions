class Solution {
  /// Applies multiple range-based letter shifts on the string `s`.
  ///
  /// Each shift is defined as [start, end, direction]:
  /// - direction == 1 → shift forward (e.g., 'a' -> 'b')
  /// - direction == 0 → shift backward (e.g., 'b' -> 'a')
  ///
  /// Uses a difference array to efficiently apply shifts.
  String shiftingLetters(String s, List<List<int>> shifts) {
    int n = s.length;

    // Step 1: Create a difference array of size `n` initialized to 0.
    // This allows range updates in O(1) time per operation.
    List<int> diffArray = List.filled(n, 0);

    // Step 2: Process each shift operation
    for (List<int> shift in shifts) {
      int start = shift[0];
      int end = shift[1];
      int direction = shift[2];

      if (direction == 1) {
        // Forward shift: increment at start index
        diffArray[start] += 1;

        // Decrement after end index to stop the effect
        if (end + 1 < n) {
          diffArray[end + 1] -= 1;
        }
      } else {
        // Backward shift: decrement at start index
        diffArray[start] -= 1;

        // Increment after end index to stop the effect
        if (end + 1 < n) {
          diffArray[end + 1] += 1;
        }
      }
    }

    // Step 3: Apply prefix sum to compute the total shifts for each position
    List<int> shiftPrefixSum = List.filled(n, 0);
    int currentShift = 0;

    for (int i = 0; i < n; i++) {
      currentShift += diffArray[i];

      // Modulo 26 to keep shift within alphabet limits
      int effectiveShift = currentShift % 26;

      // Ensure shift is non-negative (in case of backward shifts)
      if (effectiveShift < 0) {
        effectiveShift += 26;
      }

      shiftPrefixSum[i] = effectiveShift;
    }

    // Step 4: Build the result string by applying the shifts to characters
    StringBuffer result = StringBuffer();

    for (int i = 0; i < n; i++) {
      int originalCharCode = s.codeUnitAt(i) - 'a'.codeUnitAt(0);
      int newCharCode = (originalCharCode + shiftPrefixSum[i]) % 26;

      // Convert back to character and append to result
      result.writeCharCode('a'.codeUnitAt(0) + newCharCode);
    }

    return result.toString();
  }
}
