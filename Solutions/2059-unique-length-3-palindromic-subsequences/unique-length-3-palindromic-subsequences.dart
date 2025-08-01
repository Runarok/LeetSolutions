class Solution {
  int countPalindromicSubsequence(String s) {
    // Convert the string to a list of characters for easier indexing
    List<String> chars = s.split('');

    // Create a set to store unique 3-letter palindromic subsequences
    Set<String> result = {};

    // Iterate over all lowercase letters from 'a' to 'z'
    for (int i = 0; i < 26; i++) {
      String letter = String.fromCharCode('a'.codeUnitAt(0) + i);

      // Find the first and last occurrence of the current letter
      int first = s.indexOf(letter);
      int last = s.lastIndexOf(letter);

      // If the letter appears at least twice and there is space in between
      if (first != -1 && last != -1 && first < last - 1) {
        // Use a set to collect unique characters between the first and last occurrence
        Set<String> middleChars = {};

        // Iterate through the characters between first and last occurrence
        for (int j = first + 1; j < last; j++) {
          middleChars.add(chars[j]);
        }

        // Each unique middle character forms a unique palindrome of the form: letter + middle + letter
        for (String mid in middleChars) {
          result.add(letter + mid + letter);
        }
      }
    }

    // Return the number of unique palindromic subsequences
    return result.length;
  }
}
