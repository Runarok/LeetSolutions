class Solution {
  int longestSubarray(List<int> nums) {
    int maxVal = 0;            // To store the maximum value found in the array
    int ans = 0;               // To store the length of the longest subarray of max values
    int currentStreak = 0;     // To keep track of the current streak of max values

    // Iterate through each number in the input list
    for (int num in nums) {
      // If we find a number greater than current maxVal, update maxVal
      // and reset both ans and currentStreak
      if (num > maxVal) {
        maxVal = num;
        ans = 0;
        currentStreak = 0;
      }

      // If current number is equal to maxVal, increase the streak count
      if (num == maxVal) {
        currentStreak += 1;
      } else {
        // If not equal, reset the current streak
        currentStreak = 0;
      }

      // Update answer with the maximum of ans and current streak
      ans = ans > currentStreak ? ans : currentStreak;
    }

    // Return the length of the longest subarray consisting of maxVal
    return ans;
  }
}
