class Solution {
  List<int> smallestSubarrays(List<int> nums) {
    int n = nums.length;

    // Tracks the most recent index (from right to left) where each bit (0 to 30) was seen.
    List<int> pos = List.filled(31, -1);

    // This will store the result: the length of the smallest subarray starting at each index.
    List<int> ans = List.filled(n, 0);

    // Traverse from the end of the array to the beginning.
    for (int i = n - 1; i >= 0; i--) {
      // 'j' keeps track of how far we need to go to cover all bits seen so far
      int j = i;

      // Check each bit position (0 to 30)
      for (int bit = 0; bit < 31; bit++) {
        // If the current number does not have this bit set
        if ((nums[i] & (1 << bit)) == 0) {
          // But this bit was seen in a later position, update 'j' to cover that position
          if (pos[bit] != -1) {
            j = j > pos[bit] ? j : pos[bit];
          }
        } else {
          // If the bit is set in the current number, update its last seen position
          pos[bit] = i;
        }
      }

      // The length of the smallest subarray is the distance between i and j (inclusive)
      ans[i] = j - i + 1;
    }

    return ans;
  }
}
