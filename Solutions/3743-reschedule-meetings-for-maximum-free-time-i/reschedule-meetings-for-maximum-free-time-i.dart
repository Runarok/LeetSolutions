class Solution {
  int maxFreeTime(int eventTime, int k, List<int> startTime, List<int> endTime) {
    int n = startTime.length;
    int res = 0;

    // Step 1: Calculate prefix sum of durations
    List<int> prefixSum = List<int>.filled(n + 1, 0);
    for (int i = 0; i < n; i++) {
      prefixSum[i + 1] = prefixSum[i] + (endTime[i] - startTime[i]);
    }

    // Step 2: Try sliding window of size k
    for (int i = k - 1; i < n; i++) {
      // Right boundary: either next meeting's start or event end
      int right = (i == n - 1) ? eventTime : startTime[i + 1];

      // Left boundary: either 0 or end of the meeting before window
      int left = (i == k - 1) ? 0 : endTime[i - k];

      // Total meeting time in current window
      int totalDuration = prefixSum[i + 1] - prefixSum[i - k + 1];

      // Free time = available time - total meeting duration
      res = res > (right - left - totalDuration)
          ? res
          : (right - left - totalDuration);
    }

    return res;
  }
}
