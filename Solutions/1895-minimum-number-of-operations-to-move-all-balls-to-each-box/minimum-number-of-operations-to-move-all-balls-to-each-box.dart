class Solution {
  /// This function returns a list where each element at index `i`
  /// represents the total number of operations (moves) required to
  /// bring all balls in the string to box `i`.
  ///
  /// A '1' in the string represents a box with a ball, '0' means empty.
  /// Moving a ball from index `a` to `b` costs `|a - b|` operations.
  List<int> minOperations(String boxes) {
    int n = boxes.length;
    
    // Initialize result list with 0s
    List<int> answer = List.filled(n, 0);

    // Loop through each box to find which boxes contain balls ('1')
    for (int currentBox = 0; currentBox < n; currentBox++) {
      if (boxes[currentBox] == '1') {
        // For each box that has a ball, calculate how far it would take
        // to move it to every other box.
        for (int newPosition = 0; newPosition < n; newPosition++) {
          // The number of operations is the distance between current and new position
          answer[newPosition] += (newPosition - currentBox).abs();
        }
      }
    }

    return answer;
  }
}
