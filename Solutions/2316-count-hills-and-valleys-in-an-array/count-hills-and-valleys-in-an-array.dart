class Solution {
  int countHillValley(List<int> nums) {
    int res = 0; // This variable keeps track of the total number of hills and valleys.
    int n = nums.length; // Total number of elements in the list.

    // Loop through the list, starting from the second element and ending at the second-last.
    // We skip the first and last elements since they can't be a hill or valley.
    for (int i = 1; i < n - 1; i++) {
      // If the current element is equal to the previous one, we skip it.
      // This handles flat areas and prevents duplicates from being counted.
      if (nums[i] == nums[i - 1]) {
        continue;
      }

      // `left` will store the relationship between nums[i] and its nearest different neighbor to the left.
      // -1 means left neighbor is smaller (i.e., current is greater),
      //  1 means left neighbor is greater (i.e., current is smaller),
      //  0 means no useful neighbor found yet (still searching).
      int left = 0;

      // Search backwards from current index to find the first different value
      for (int j = i - 1; j >= 0; j--) {
        if (nums[j] > nums[i]) {
          left = 1; // Left neighbor is greater → current is smaller on left side
          break;
        } else if (nums[j] < nums[i]) {
          left = -1; // Left neighbor is smaller → current is greater on left side
          break;
        }
        // If nums[j] == nums[i], continue searching
      }

      // `right` will store the relationship between nums[i] and its nearest different neighbor to the right.
      // Same rules as `left`: -1 = smaller, 1 = greater, 0 = unknown.
      int right = 0;

      // Search forward from current index to find the first different value
      for (int j = i + 1; j < n; j++) {
        if (nums[j] > nums[i]) {
          right = 1; // Right neighbor is greater → current is smaller on right side
          break;
        } else if (nums[j] < nums[i]) {
          right = -1; // Right neighbor is smaller → current is greater on right side
          break;
        }
        // If nums[j] == nums[i], continue searching
      }

      // If both left and right have the same non-zero relationship to the current value:
      // - If both are 1, current is smaller than both sides → it's a valley
      // - If both are -1, current is greater than both sides → it's a hill
      if (left == right && left != 0) {
        res++; // Count this index as a hill or valley
      }
    }

    return res; // Return the total number of hills and valleys found
  }
}
