class Solution {
  String findKthBit(int n, int k) {
    // Recursive helper function
    // It returns the kth bit of Sn (1-based index)
    String helper(int n, int k) {
      // Base case: S1 = "0"
      if (n == 1) return "0";

      // Length of Sn is 2^n - 1
      int length = (1 << n) - 1;
      int mid = (length >> 1) + 1; // middle index (1-based)

      if (k == mid) {
        // Middle bit is always "1"
        return "1";
      } else if (k < mid) {
        // If k is in the first half, it's the same as in Sn-1
        return helper(n - 1, k);
      } else {
        // If k is in the second half:
        // It's in the reversed inverted part of Sn-1
        // Find the mirrored position in Sn-1
        int mirroredK = mid - (k - mid);
        String bit = helper(n - 1, mirroredK);
        // Invert the bit: "0" -> "1", "1" -> "0"
        return bit == "0" ? "1" : "0";
      }
    }

    // Call the recursive helper
    return helper(n, k);
  }
}
