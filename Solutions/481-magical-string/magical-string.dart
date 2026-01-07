class Solution {
  int magicalString(int n) {
    // Edge case: if n <= 0, there are no 1's
    if (n <= 0) return 0;
    // Edge case: if n <= 3, the string starts as "1 2 2"
    if (n <= 3) return 1;

    // Step 1: Initialize the magical string as a list for easy updates
    List<int> s = List.filled(n, 0);
    s[0] = 1;
    s[1] = 2;
    s[2] = 2;

    int countOnes = 1;  // The first '1' is already counted
    int i = 2;          // Pointer to read the current group count
    int idx = 3;        // Next position to write in s

    // Step 2: Build the magical string up to length n
    while (idx < n) {
      // Determine the next number to write: alternate between 1 and 2
      int nextNum = s[idx - 1] == 1 ? 2 : 1;

      // Repeat nextNum s[i] times
      for (int j = 0; j < s[i] && idx < n; j++) {
        s[idx] = nextNum;
        if (nextNum == 1) countOnes++;
        idx++;
      }
      i++; // Move to the next group in s
    }

    return countOnes;
  }
}
