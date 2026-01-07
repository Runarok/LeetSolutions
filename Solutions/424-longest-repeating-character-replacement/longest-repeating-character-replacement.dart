class Solution {
  int characterReplacement(String s, int k) {
    List<int> count = List.filled(26, 0); // count of letters A-Z
    int left = 0;
    int maxCount = 0; // max frequency in the current window
    int result = 0;
    
    for (int right = 0; right < s.length; right++) {
      int index = s.codeUnitAt(right) - 'A'.codeUnitAt(0);
      count[index]++;
      
      // update the max frequency character in the window
      maxCount = count[index] > maxCount ? count[index] : maxCount;
      
      // if we need to change more than k letters, shrink window from left
      while ((right - left + 1) - maxCount > k) {
        int leftIndex = s.codeUnitAt(left) - 'A'.codeUnitAt(0);
        count[leftIndex]--;
        left++;
      }
      
      // update result with the current window size
      result = (right - left + 1) > result ? (right - left + 1) : result;
    }
    
    return result;
  }
}
