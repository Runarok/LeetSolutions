class Solution {
public:
    // This function returns the minimum number of deci-binary numbers
    // needed to sum up to the given decimal string n.
    //
    // A deci-binary number contains only digits 0 or 1.
    //
    // Key Idea:
    // The minimum number of deci-binary numbers required
    // is equal to the maximum digit present in the string.
    //
    // Why?
    // Because for each digit position:
    // - If the digit is 8, we need at least 8 deci-binary numbers
    //   contributing a '1' at that position to sum to 8.
    // - So the largest digit determines the answer.
    static int minPartitions(string& n) {
        
        // Variable to store the maximum digit found so far.
        int ans = 0;

        // Loop through each character in the string.
        // Note: although we use 'int x', each element of string is actually a char.
        // So 'x' represents the ASCII value of the character.
        for (int x : n) {

            // Convert character digit to integer digit:
            // Example:
            // '5' (ASCII 53) - '0' (ASCII 48) = 5
            //
            // Update ans with the maximum digit found so far.
            ans = max(ans, x - '0');

            // Optimization:
            // If we ever find digit 9, we can stop immediately.
            //
            // Why?
            // Because 9 is the highest possible digit in decimal.
            // We cannot get anything larger, so no need to continue checking.
            if (ans == 9) 
                break;
        }

        // Return the maximum digit found,
        // which equals the minimum number of deci-binary numbers needed.
        return ans;
    }
};