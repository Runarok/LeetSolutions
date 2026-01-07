class Solution {
  int search(List<int> nums, int target) {
    // Initialize the left and right pointers for binary search
    int left = 0;
    int right = nums.length - 1;

    // Continue searching while left <= right
    while (left <= right) {
      // Find the middle index
      int mid = left + (right - left) ~/ 2;

      // Check if the middle element is the target
      if (nums[mid] == target) {
        return mid; // Target found, return index
      } 
      // If target is greater than middle element, search the right half
      else if (nums[mid] < target) {
        left = mid + 1;
      } 
      // If target is smaller than middle element, search the left half
      else {
        right = mid - 1;
      }
    }

    // Target was not found
    return -1;
  }
}
