class Solution {
  int search(List<int> nums, int target) {
    // Initialize two pointers for binary search
    int left = 0;                // Start of the array
    int right = nums.length - 1; // End of the array

    // Binary search loop
    while (left <= right) {
      // Find the middle index
      int mid = left + ((right - left) ~/ 2);

      // Check if the middle element is the target
      if (nums[mid] == target) {
        return mid; // Target found, return index
      }

      // Determine which side is sorted
      if (nums[left] <= nums[mid]) {
        // Left side from 'left' to 'mid' is sorted
        if (nums[left] <= target && target < nums[mid]) {
          // Target is within the sorted left half
          right = mid - 1; // Narrow search to left half
        } else {
          // Target is not in left half
          left = mid + 1; // Search in the right half
        }
      } else {
        // Right side from 'mid' to 'right' is sorted
        if (nums[mid] < target && target <= nums[right]) {
          // Target is within the sorted right half
          left = mid + 1; // Narrow search to right half
        } else {
          // Target is not in right half
          right = mid - 1; // Search in the left half
        }
      }
    }

    // Target was not found in the array
    return -1;
  }
}
