class Solution {
  int countMaxOrSubsets(List<int> nums) {
    int maxOrValue = 0;

    // Calculate the maximum OR value of all numbers
    for (int num in nums) {
      maxOrValue |= num;
    }

    // Start the recursive count from index 0, with current OR as 0
    return _countSubsets(nums, 0, 0, maxOrValue);
  }

  int _countSubsets(List<int> nums, int index, int currentOr, int targetOr) {
    // Base case: reached the end of the array
    if (index == nums.length) {
      return currentOr == targetOr ? 1 : 0;
    }

    // Don't include the current number
    int countWithout = _countSubsets(nums, index + 1, currentOr, targetOr);

    // Include the current number (use bitwise OR)
    int countWith = _countSubsets(
      nums,
      index + 1,
      currentOr | nums[index],
      targetOr,
    );

    // Return the sum of both inclusion and exclusion
    return countWithout + countWith;
  }
}
