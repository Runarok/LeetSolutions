class Solution {
  /// Finds the k-th smallest number in lexicographical order within [1, n]
  int findKthNumber(int n, int k) {
    int curr = 1; // Start from 1 (the smallest number in lexicographical order)
    k--; // We already count 1 as the first number, so we decrease k by 1

    while (k > 0) {
      // Count how many numbers exist in the lexicographical subtree
      // rooted at `curr`, but before reaching the next sibling (`curr + 1`)
      int steps = _countSteps(n, curr, curr + 1);

      if (steps <= k) {
        // If the entire subtree under `curr` is less than or equal to k,
        // we can skip it and move to the next sibling
        curr++;      // Move to next sibling (e.g., from 1 → 2)
        k -= steps;  // Decrease k by the number of nodes we skipped
      } else {
        // If the k-th number lies within the subtree rooted at `curr`
        curr *= 10;  // Go deeper into the subtree (e.g., 1 → 10)
        k--;         // We consumed 1 step by choosing this new root
      }
    }

    // When k becomes 0, curr is the answer
    return curr;
  }

  /// Counts how many numbers exist between two prefixes (prefix1 and prefix2)
  /// in the lexicographical order, within the upper bound `n`.
  ///
  /// For example, if prefix1 = 1 and prefix2 = 2, it counts all numbers
  /// like 1, 10, 11, ..., 19, that are less than or equal to n.
  int _countSteps(int n, int prefix1, int prefix2) {
    int steps = 0;

    // Go level by level in the virtual lexicographical tree
    while (prefix1 <= n) {
      // At each level, calculate how many numbers are between prefix1 and prefix2
      // but do not exceed the upper limit n
      steps += (prefix2 <= n + 1 ? prefix2 : n + 1) - prefix1;

      // Go one level deeper in the tree (add one more digit)
      prefix1 *= 10;
      prefix2 *= 10;
    }

    return steps;
  }
}
