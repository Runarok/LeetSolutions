class Solution {
  bool isValid(String word) {
    // Rule 1: Word must be at least 3 characters long
    if (word.length < 3) {
      return false;
    }

    // Flags to track presence of at least one vowel and one consonant
    bool hasVowel = false;
    bool hasConsonant = false;

    for (int i = 0; i < word.length; i++) {
      String c = word[i];

      // Check if character is a letter
      if (_isAsciiAlphabetic(c)) {
        // Convert character to lowercase for uniform comparison
        String lc = c.toLowerCase();

        // Check if the character is a vowel
        if ('aeiou'.contains(lc)) {
          hasVowel = true;
        } else {
          // Otherwise, it's a consonant
          hasConsonant = true;
        }
      } 
      // If not a digit or a letter, it's invalid
      else if (!_isAsciiDigit(c)) {
        return false;
      }
    }

    // Final rule: must have at least one vowel and one consonant
    return hasVowel && hasConsonant;
  }

  // Helper to check if a character is an ASCII letter
  bool _isAsciiAlphabetic(String c) {
    int code = c.codeUnitAt(0);
    return (code >= 65 && code <= 90) || (code >= 97 && code <= 122);
  }

  // Helper to check if a character is an ASCII digit
  bool _isAsciiDigit(String c) {
    int code = c.codeUnitAt(0);
    return code >= 48 && code <= 57;
  }
}
