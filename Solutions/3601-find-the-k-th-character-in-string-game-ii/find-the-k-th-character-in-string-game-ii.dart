class Solution {
  String kthCharacter(int k, List<int> operations) {
    int ans = 0; // This counts how many non-zero operations we encounter on the path to k

    // Traverse from k back toward 1, analyzing the binary tree structure
    while (k != 1) {
      // Find the position of the highest set bit (similar to log2(k))
      int t = 63 - _leadingZeros(k);

      // If k is a power of 2 (only one bit is set), adjust t by subtracting 1
      // Because we want the highest t such that 2^t < k
      t = ((1 << t) == k) ? t - 1 : t;

      // Move k "up" the virtual binary tree by subtracting 2^t
      k -= 1 << t;

      // If the operation at level t is non-zero, increase the counter
      if (operations[t] != 0) {
        ans += 1;
      }
    }

    // Convert the count into a lowercase letter by cycling through the alphabet (mod 26)
    return String.fromCharCode('a'.codeUnitAt(0) + (ans % 26));
  }

  // Simulates Rust's leading_zeros for a 64-bit integer
  // Counts the number of zero bits before the first set bit from the left
  int _leadingZeros(int x) {
    if (x == 0) return 64;
    int count = 0;
    for (int i = 63; i >= 0; i--) {
      if ((x & (1 << i)) != 0) break;
      count++;
    }
    return count;
  }
}
