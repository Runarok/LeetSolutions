class Solution {
  int threeSumClosest(List<int> nums, int target) {
    // Step 1: Sort the array to use two pointers
    nums.sort();

    // Step 2: Initialize the closest sum with a large number
    int closest = nums[0] + nums[1] + nums[2]; // initial sum of first three elements

    // Step 3: Iterate through each number as the first element of the triplet
    for (int i = 0; i < nums.length - 2; i++) {
      int left = i + 1;          // pointer just after i
      int right = nums.length - 1; // pointer at the end of the array

      // Step 4: Use two pointers to find the best pair with nums[i]
      while (left < right) {
        int sum = nums[i] + nums[left] + nums[right];

        // If this sum is closer to target than previous closest, update it
        if ((sum - target).abs() < (closest - target).abs()) {
          closest = sum;
        }

        // Move pointers based on comparison
        if (sum < target) {
          left++;  // Need a larger sum
        } else if (sum > target) {
          right--; // Need a smaller sum
        } else {
          // Exact match found
          return sum;
        }
      }
    }

    // Step 5: Return the closest sum found
    return closest;
  }
}
