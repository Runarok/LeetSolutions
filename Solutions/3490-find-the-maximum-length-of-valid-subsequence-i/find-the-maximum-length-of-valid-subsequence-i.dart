class Solution {
  int maximumLength(List<int> nums) {
    int res = 0; // Variable to store the maximum length found

    // Define the 4 possible patterns of even/odd sequences
    List<List<int>> patterns = [
      [0, 0], // Even, Even
      [0, 1], // Even, Odd
      [1, 0], // Odd, Even
      [1, 1]  // Odd, Odd
    ];

    // Try each pattern to find the longest matching subsequence
    for (var pattern in patterns) {
      int cnt = 0; // Counter for current matching subsequence length

      for (int num in nums) {
        // Check if the number's parity matches the expected pattern
        if (num % 2 == pattern[cnt % 2]) {
          cnt++; // If match, increment the length of current sequence
        }
      }

      // Update result if this pattern gave a longer sequence
      res = res > cnt ? res : cnt;
    }

    return res; // Return the maximum length found
  }
}
