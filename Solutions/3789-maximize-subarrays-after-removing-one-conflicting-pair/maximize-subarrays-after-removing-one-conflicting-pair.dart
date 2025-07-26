class Solution {
  int maxSubarrays(int n, List<List<int>> conflictingPairs) {
    // Arrays to store the first and second smallest conflicting values for each index
    List<int> bMin1 = List.filled(n + 1, 1 << 30); // Equivalent to i32::MAX
    List<int> bMin2 = List.filled(n + 1, 1 << 30);

    // Process each conflicting pair
    for (var pair in conflictingPairs) {
      int a = pair[0].compareTo(pair[1]) < 0 ? pair[0] : pair[1]; // min of the two
      int b = pair[0].compareTo(pair[1]) > 0 ? pair[0] : pair[1]; // max of the two

      // Store the two smallest conflicts for index `a`
      if (bMin1[a] > b) {
        bMin2[a] = bMin1[a];
        bMin1[a] = b;
      } else if (bMin2[a] > b) {
        bMin2[a] = b;
      }
    }

    int res = 0;
    int ib1 = n;
    int b2 = 1 << 30; // Track the overall second minimum conflict
    List<int> delCount = List.filled(n + 1, 0); // Tracks how many "deletions" to skip over

    // Traverse from right to left
    for (int i = n; i >= 1; i--) {
      if (bMin1[ib1] > bMin1[i]) {
        b2 = b2 < bMin1[ib1] ? b2 : bMin1[ib1];
        ib1 = i;
      } else {
        b2 = b2 < bMin1[i] ? b2 : bMin1[i];
      }

      // Count valid subarrays starting at i
      int validEnd = bMin1[ib1] < n + 1 ? bMin1[ib1] : n + 1;
      res += validEnd - i;

      // Count how many of those can be extended
      int delEnd = [
        b2,
        bMin2[ib1],
        n + 1
      ].reduce((a, b) => a < b ? a : b);
      delCount[ib1] += delEnd - validEnd;
    }

    // Add the best extension (max in delCount)
    int maxDel = delCount.reduce((a, b) => a > b ? a : b);
    return res + maxDel;
  }
}
