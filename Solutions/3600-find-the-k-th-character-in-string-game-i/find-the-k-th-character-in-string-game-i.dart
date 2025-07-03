class Solution {
  String kthCharacter(int k) {
    // Count the number of 1's in the binary representation of (k - 1)
    // This is equivalent to how many "right turns" you'd take in a binary tree path
    // from the root to the k-th leaf in an in-order traversal.
    int ones = _popCount(k - 1);

    // Convert 'a' (char) to its ASCII code, add the number of 1's,
    // then convert back to a character.
    // For example, if ones = 2, then 'a' + 2 = 'c'
    return String.fromCharCode('a'.codeUnitAt(0) + ones);
  }

  /// This helper function counts the number of set bits (1s) in an integer.
  /// It's a classic "Hamming weight" or "popcount" algorithm.
  /// Example:
  /// n = 13 -> binary = 1101 -> popcount = 3
  int _popCount(int n) {
    int count = 0;

    // Loop until all bits are cleared
    while (n > 0) {
      // n & (n - 1) clears the lowest set bit in n
      // This reduces the number of iterations to the number of set bits
      n &= (n - 1);
      count++;
    }

    return count;
  }
}
