class Solution {
  List<int> findRightInterval(List<List<int>> intervals) {
    int n = intervals.length;
    
    // Step 1: Keep track of original indices
    // Pair each interval's start with its original index
    List<List<int>> starts = [];
    for (int i = 0; i < n; i++) {
      starts.add([intervals[i][0], i]);
    }
    
    // Step 2: Sort intervals by their start value
    starts.sort((a, b) => a[0] - b[0]);
    
    // Step 3: Prepare result array
    List<int> result = List.filled(n, -1);
    
    // Step 4: For each interval, find the smallest start >= its end
    for (int i = 0; i < n; i++) {
      int end = intervals[i][1];
      int left = 0, right = n - 1;
      int idx = -1;  // Default -1 if no right interval found
      
      // Binary search
      while (left <= right) {
        int mid = left + ((right - left) >> 1);
        if (starts[mid][0] >= end) {
          // Found a candidate, try to find a smaller start
          idx = starts[mid][1];
          right = mid - 1;
        } else {
          left = mid + 1;
        }
      }
      
      result[i] = idx;
    }
    
    return result;
  }
}
