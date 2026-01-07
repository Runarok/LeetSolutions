class Solution {
  List<List<int>> combine(int n, int k) {
    // This will store all the combinations
    List<List<int>> result = [];

    // Helper function for backtracking
    void backtrack(int start, List<int> current) {
      // Base case: if the current combination has k numbers, add it to result
      if (current.length == k) {
        result.add(List.from(current)); // Make a copy of current
        return;
      }

      // Try all possible numbers starting from 'start' to 'n'
      for (int i = start; i <= n; i++) {
        current.add(i); // Choose number i
        backtrack(i + 1, current); // Recurse with next numbers
        current.removeLast(); // Backtrack: remove i and try next
      }
    }

    // Start backtracking from 1 with an empty combination
    backtrack(1, []);
    
    return result;
  }
}
