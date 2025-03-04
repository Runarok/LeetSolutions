/**
 * @param {number} n
 * @return {boolean}
 */

var checkPowersOfThree = function(n) {
    while (n > 0) {
        if (n % 3 === 2) {
            return false; // If any digit is 2 in base-3, return false.
        }
        n = Math.floor(n / 3); // Move to the next digit in base-3.
    }
    return true; // All digits are 0 or 1 in base-3.
};
