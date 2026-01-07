class Solution {
  int peakIndexInMountainArray(List<int> arr) {
    // Initialize the start and end pointers for binary search
    int left = 0;
    int right = arr.length - 1;
    
    // Continue searching while left < right
    while (left < right) {
      // Find the middle index
      int mid = left + (right - left) ~/ 2;
      
      // If the middle element is less than the next element,
      // we are in the increasing slope, so the peak is to the right
      if (arr[mid] < arr[mid + 1]) {
        left = mid + 1;
      } else {
        // If middle element is greater than the next element,
        // we are in the decreasing slope, so the peak is at mid or to the left
        right = mid;
      }
    }
    
    // When left == right, we have found the peak
    return left;
  }
}
