class Solution {

  // This function returns the minimum number of operations
  // needed to make the string alternating (either starting with '1' or '0')
  int minOperations(String s) {
    
    // Case 1: Make the string alternate starting with '1'
    // Example: if s = "0101", target becomes "1010"
    int startWithOne = diff(s, startWith(s, '1'));
    
    // Case 2: Make the string alternate starting with '0'
    // Example: if s = "0101", target becomes "0101"
    int startWithZero = diff(s, startWith(s, '0'));
    
    // Return the minimum number of changes required
    return min(startWithOne, startWithZero);
  }

  // This function generates an alternating string of the same length as s
  // starting with character c ('1' or '0')
  String startWith(String s, String c) {
    
    // Determine if we start with '1'
    bool isOne = (c == '1') ? true : false;
    
    // This will store the generated alternating string
    String res = '';
    
    // Loop through the length of the original string
    for (int i = 0; i < s.length; i++) {
      
      // Append '1' if isOne is true, otherwise append '0'
      res += isOne ? '1' : '0';
      
      // Flip the boolean value so next character alternates
      isOne = !isOne;
    }
    
    // Return the constructed alternating string
    return res;
  }

  // This function calculates how many characters differ
  // between original string s and the target alternating string op
  int diff(String s, String op) {
    
    // Counter for number of differences
    int res = 0;
    
    // Compare each character of both strings
    for (int i = 0; i < s.length; i++) {
      
      // If characters are different, increment counter
      if (s[i] != op[i]) {
        res++;
      }
    }
    
    // Return total number of mismatched positions
    return res;
  }
}