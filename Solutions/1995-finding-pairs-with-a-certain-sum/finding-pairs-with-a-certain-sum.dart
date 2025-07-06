class FindSumPairs {
  late List<int> nums1;
  late List<int> nums2;
  final Map<int, int> cnt = {};

  // Constructor: initializes the nums1 and nums2 arrays, and builds a frequency map (cnt) for nums2
  FindSumPairs(List<int> nums1, List<int> nums2) {
    this.nums1 = nums1;
    this.nums2 = nums2;

    // Populate the count map with frequencies of elements in nums2
    for (int num in nums2) {
      cnt[num] = (cnt[num] ?? 0) + 1;
    }
  }

  // Adds 'val' to nums2[index] and updates the frequency map accordingly
  void add(int index, int val) {
    int oldVal = nums2[index];
    
    // Decrement frequency of old value
    cnt[oldVal] = (cnt[oldVal] ?? 0) - 1;
    if (cnt[oldVal] == 0) {
      cnt.remove(oldVal); // Remove key if count becomes 0 to keep map clean
    }

    // Update value in nums2
    nums2[index] += val;
    int newVal = nums2[index];

    // Increment frequency of new value
    cnt[newVal] = (cnt[newVal] ?? 0) + 1;
  }

  // Returns the number of pairs (i, j) such that nums1[i] + nums2[j] == tot
  int count(int tot) {
    int ans = 0;

    for (int num in nums1) {
      int rest = tot - num;

      // Add the count of 'rest' from nums2 (if it exists)
      ans += cnt[rest] ?? 0;
    }

    return ans;
  }
}

/*
 * Example usage:
 * FindSumPairs obj = FindSumPairs(nums1, nums2);
 * obj.add(index, val);
 * int result = obj.count(tot);
 */
