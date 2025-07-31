class Solution {
  int subarrayBitwiseORs(List<int> arr) {
    // A set to store the final result of all unique bitwise ORs.
    Set<int> ans = {};

    // A set to store the current subarray OR results from the previous iteration.
    Set<int> cur = {0};

    for (int x in arr) {
      // A new set to hold OR results including the current number.
      Set<int> cur2 = {};

      // Compute OR of current number with each element in previous result set.
      for (int y in cur) {
        cur2.add(x | y);
      }

      // Also add the current number itself as a possible subarray.
      cur2.add(x);

      // Update current set with new OR results.
      cur = cur2;

      // Add all current OR results to the final answer set.
      ans.addAll(cur);
    }

    // Return the number of unique bitwise OR results from all subarrays.
    return ans.length;
  }
}
