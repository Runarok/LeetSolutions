class Solution {
  bool canPartition(List<int> nums) {
    int totalSum = nums.reduce((a, b) => a + b);

    // If the total sum is odd, we can't partition it equally
    if (totalSum % 2 != 0) {
      return false;
    }

    int target = totalSum ~/ 2;
    return canPartitionDP(nums, target);
  }

  bool canPartitionDP(List<int> nums, int target) {
    // Initialize a DP array where dp[i] is true if a subset sum of i is possible
    List<bool> dp = List.filled(target + 1, false);
    dp[0] = true; // Base case: zero sum is always possible (empty subset)

    for (int num in nums) {
      // Update DP array in reverse to avoid using the same element twice
      for (int j = target; j >= num; j--) {
        if (dp[j - num]) {
          dp[j] = true;
        }
      }
    }

    return dp[target];
  }
}
