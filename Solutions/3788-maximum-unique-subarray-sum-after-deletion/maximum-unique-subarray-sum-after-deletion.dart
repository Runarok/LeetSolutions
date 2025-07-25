class Solution {
  int maxSum(List<int> nums) {
    // Create a set of positive numbers from the list
    Set<int> positiveNumsSet = nums.where((num) => num > 0).toSet();

    // If there are no positive numbers, return the maximum number from the list
    if (positiveNumsSet.isEmpty) {
      return nums.reduce((a, b) => a > b ? a : b); // Equivalent to Python's max(nums)
    }

    // Otherwise, return the sum of the positive unique numbers
    return positiveNumsSet.reduce((a, b) => a + b); // Equivalent to Python's sum(set)
  }
}
