class Solution {
  String makeFancyString(String s) {
    // Use a StringBuffer in Dart instead of StringBuilder
    StringBuffer result = StringBuffer();

    // Track how many times the current character appears consecutively
    int count = 1;

    for (int i = 0; i < s.length; i++) {
      // Always add the first character
      if (i == 0) {
        result.write(s[i]);
        continue;
      }

      // Check if current character is same as previous
      if (s[i] == s[i - 1]) {
        count++;
      } else {
        count = 1; // Reset count when character changes
      }

      // Only append character if it doesn't make 3 in a row
      if (count < 3) {
        result.write(s[i]);
      }
    }

    // Convert result to string
    return result.toString();
  }
}
