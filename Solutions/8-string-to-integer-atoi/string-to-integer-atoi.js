/**
 * @param {string} s
 * @return {number}
 */
var myAtoi = function(s) {
    // Trim leading and trailing whitespaces
    s = s.trim();

    // Handle edge case: empty string after trimming
    if (s.length === 0) {
        return 0;
    }

    // Initialize variables
    let i = 0;
    let sign = 1; // Default to positive
    let result = 0;
    
    // Check for sign
    if (s[i] === '-' || s[i] === '+') {
        sign = s[i] === '-' ? -1 : 1;
        i++; // Move past the sign
    }

    // Convert the digits to integer
    while (i < s.length && isDigit(s[i])) {
        let digit = s[i] - '0'; // Convert character to digit
        result = result * 10 + digit;
        i++;
    }

    // Apply the sign
    result *= sign;

    // Check for overflow and clamp the result to 32-bit integer range
    if (result < Math.pow(-2, 31)) {
        return Math.pow(-2, 31);
    }
    if (result > Math.pow(2, 31) - 1) {
        return Math.pow(2, 31) - 1;
    }

    return result;
};

// Helper function to check if a character is a digit
function isDigit(c) {
    return c >= '0' && c <= '9';
}
