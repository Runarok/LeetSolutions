class Solution {

  // Function to check if the binary string contains
  // only ONE continuous segment of '1's
  bool checkOnesSegment(String s) {

    // If the string contains only '1's OR only '0's,
    // then it automatically satisfies the condition
    // because there cannot be multiple segments of '1's
    if(!s.contains('1') || !s.contains('0')) return true;

    // This variable becomes true once we encounter
    // the first '1' in the string
    bool found = false;

    // This variable will store the index of the
    // last '1' in the first segment of '1's
    int indexOfLastOne = 0;

    // Loop through every character in the string
    for(int i = 0; i < s.length; i++) {

        // If current character is '1',
        // mark that we have found a '1'
        if(s[i] == '1') 
            found = true;

        // If we already found '1's and now encounter '0',
        // it means the first segment of '1's has ended
        if(found && s[i] == '0') {

            // Store the index of the last '1'
            // which is just before this '0'
            indexOfLastOne = i - 1;

            // Stop the loop since we only care
            // about the first segment
            break;
        }
    }

    // Compare the last '1' in the entire string
    // with the last '1' from the first segment.
    // If they are the same, then there was only
    // one segment of '1's.
    // Otherwise, there exists another segment later.
    return s.lastIndexOf('1') == indexOfLastOne;
  }
}