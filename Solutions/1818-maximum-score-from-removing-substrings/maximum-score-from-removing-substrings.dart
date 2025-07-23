class Solution {
  int maximumGain(String s, int x, int y) {
    int totalScore = 0;
    String highPriorityPair = x > y ? 'ab' : 'ba';
    String lowPriorityPair = highPriorityPair == 'ab' ? 'ba' : 'ab';

    // First pass: remove high priority pair
    String stringAfterFirstPass = removeSubstring(s, highPriorityPair);
    int removedPairsCount = (s.length - stringAfterFirstPass.length) ~/ 2;

    // Calculate score from first pass
    totalScore += removedPairsCount * (x > y ? x : y);

    // Second pass: remove low priority pair
    String stringAfterSecondPass = removeSubstring(stringAfterFirstPass, lowPriorityPair);
    removedPairsCount = (stringAfterFirstPass.length - stringAfterSecondPass.length) ~/ 2;

    // Calculate score from second pass
    totalScore += removedPairsCount * (x > y ? y : x);

    return totalScore;
  }

  String removeSubstring(String input, String targetPair) {
    List<String> charStack = [];

    for (int i = 0; i < input.length; i++) {
      String currentChar = input[i];
      if (charStack.isNotEmpty &&
          currentChar == targetPair[1] &&
          charStack.last == targetPair[0]) {
        charStack.removeLast(); // Remove matching character
      } else {
        charStack.add(currentChar);
      }
    }

    return charStack.join('');
  }
}
