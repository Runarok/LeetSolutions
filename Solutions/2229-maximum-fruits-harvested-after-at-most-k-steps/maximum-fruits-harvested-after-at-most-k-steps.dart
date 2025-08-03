import 'dart:math';

class Solution {
  int maxTotalFruits(List<List<int>> fruits, int startPos, int k) {
    int left = 0;
    int right = 0;
    int n = fruits.length;
    int total = 0;
    int ans = 0;

    // Helper to calculate the minimum steps to collect fruits in window
    int step(int left, int right) {
      if (fruits[right][0] <= startPos) {
        // All fruits on or to the left
        return startPos - fruits[left][0];
      } else if (fruits[left][0] >= startPos) {
        // All fruits on or to the right
        return fruits[right][0] - startPos;
      } else {
        // Fruits on both sides, go to farthest in one direction, then across
        return min(
          (startPos - fruits[left][0]).abs(),
          (startPos - fruits[right][0]).abs(),
        ) + (fruits[right][0] - fruits[left][0]);
      }
    }

    // Sliding window over fruit positions
    while (right < n) {
      total += fruits[right][1];

      // Shrink window if step cost exceeds k
      while (left <= right && step(left, right) > k) {
        total -= fruits[left][1];
        left++;
      }

      // Track the max fruits collected within allowed steps
      ans = max(ans, total);
      right++;
    }

    return ans;
  }
}
