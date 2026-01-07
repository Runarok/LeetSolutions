class Solution {
  /// Merge nums2 into nums1 in-place, assuming nums1 has enough space at the end
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    // Pointers for nums1, nums2, and the end of merged array
    int i = m - 1;        // Last element in the original nums1
    int j = n - 1;        // Last element in nums2
    int k = m + n - 1;    // Last position in nums1

    // Merge from the end to the beginning
    while (i >= 0 && j >= 0) {
      // Compare elements from the end of nums1 and nums2
      if (nums1[i] > nums2[j]) {
        nums1[k] = nums1[i];  // Place the larger element at the end
        i--;
      } else {
        nums1[k] = nums2[j];  // Place nums2 element
        j--;
      }
      k--;
    }

    // If any elements remain in nums2, copy them
    // (If nums1 elements remain, they are already in place)
    while (j >= 0) {
      nums1[k] = nums2[j];
      j--;
      k--;
    }
  }
}
