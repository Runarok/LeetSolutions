class Solution {
  String decodeString(String s) {
    // Stack for numbers (repeat counts)
    List<int> countStack = [];
    // Stack for strings (previous strings)
    List<String> stringStack = [];
    // Current string being built
    String current = "";
    // Current number being parsed
    int k = 0;

    for (int i = 0; i < s.length; i++) {
      String ch = s[i];

      if (RegExp(r'\d').hasMatch(ch)) {
        // If the character is a digit, build the number
        k = k * 10 + int.parse(ch);
      } else if (ch == "[") {
        // Push the current number and current string onto their stacks
        countStack.add(k);
        stringStack.add(current);
        // Reset for the next segment inside brackets
        current = "";
        k = 0;
      } else if (ch == "]") {
        // Pop the last number and string
        int repeat = countStack.removeLast();
        String prev = stringStack.removeLast();
        // Repeat current string 'repeat' times and append to previous string
        current = prev + current * repeat;
      } else {
        // Regular character, append to current string
        current += ch;
      }
    }

    return current;
  }
}
