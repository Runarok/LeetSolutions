/**
 * @param {number} x
 * @return {number}
 */
var reverse = function(x) {
    // Handle the sign of the number
    let sign = x < 0 ? -1 : 1;
    x = Math.abs(x);

    // Reverse the digits of the absolute value
    let reversed = 0;
    while (x !== 0) {
        let digit = x % 10;
        reversed = reversed * 10 + digit;
        x = Math.floor(x / 10);
    }

    // Reapply the sign
    reversed *= sign;

    // Check for overflow and return 0 if necessary
    if (reversed < Math.pow(-2, 31) || reversed > Math.pow(2, 31) - 1) {
        return 0;
    }

    return reversed;
};
