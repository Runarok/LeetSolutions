class Solution {
  bool containsNearbyDuplicate(List<int> nums, int k) {
    // Create a map to store the last seen index of each number
    Map<int, int> lastSeen = {};

    // Iterate over the array
    for (int i = 0; i < nums.length; i++) {
      int num = nums[i];

      // If the number was seen before
      if (lastSeen.containsKey(num)) {
        int prevIndex = lastSeen[num]!;
        // Check if the difference of indices is <= k
        if (i - prevIndex <= k) {
          return true; // Found nearby duplicate
        }
      }

      // Update the last seen index of the current number
      lastSeen[num] = i;
    }

    // No nearby duplicate found
    return false;
  }
}
