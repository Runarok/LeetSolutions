class Solution {
  int minimumDifference(List<int> nums, int k) {
    if (k <= 1) return 0;

    nums.sort();
    int minDiff = 1 << 30; // large number

    for (int i = 0; i + k - 1 < nums.length; i++) {
      int diff = nums[i + k - 1] - nums[i];
      if (diff < minDiff) {
        minDiff = diff;
      }
    }

    return minDiff;
  }
}
