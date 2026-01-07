class Solution {
  /// Main function to count reverse pairs
  int reversePairs(List<int> nums) {
    // Edge case: empty array has 0 reverse pairs
    if (nums.isEmpty) return 0;

    // Helper function: performs merge sort and counts reverse pairs
    int mergeSort(List<int> arr, int left, int right) {
      // Base case: one element or invalid range has no reverse pairs
      if (left >= right) return 0;

      // Split the array into two halves
      int mid = left + (right - left) ~/ 2;

      // Count reverse pairs in left half and right half recursively
      int count = mergeSort(arr, left, mid) + mergeSort(arr, mid + 1, right);

      // Count reverse pairs where i in left half, j in right half
      int j = mid + 1;
      for (int i = left; i <= mid; i++) {
        // Move j until the condition nums[i] > 2 * nums[j] is false
        while (j <= right && arr[i] > 2 * arr[j]) {
          j++;
        }
        // All elements from mid+1 to j-1 satisfy the reverse pair condition
        count += (j - (mid + 1));
      }

      // Merge the two sorted halves
      List<int> temp = [];
      int i = left;
      j = mid + 1;
      while (i <= mid && j <= right) {
        if (arr[i] <= arr[j]) {
          temp.add(arr[i]);
          i++;
        } else {
          temp.add(arr[j]);
          j++;
        }
      }

      // Append remaining elements
      while (i <= mid) temp.add(arr[i++]);
      while (j <= right) temp.add(arr[j++]);

      // Copy back to original array
      for (int k = 0; k < temp.length; k++) {
        arr[left + k] = temp[k];
      }

      return count;
    }

    // Call mergeSort on the full array
    return mergeSort(nums, 0, nums.length - 1);
  }
}
