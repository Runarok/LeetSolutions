#include <stdlib.h>

/**
 * Function: plusOne
 * -----------------
 * Adds one to a large integer represented as an array of digits.
 *
 * digits: array of digits representing the integer (most significant first)
 * digitsSize: number of digits
 * returnSize: pointer to store the size of the returned array
 *
 * returns: dynamically allocated array of digits representing the incremented integer
 */
int* plusOne(int* digits, int digitsSize, int* returnSize) {
    // Allocate memory for the result (could be digitsSize or digitsSize + 1 if carry)
    int* result = (int*)malloc(sizeof(int) * (digitsSize + 1));

    int carry = 1; // Start with adding one
    for (int i = digitsSize - 1; i >= 0; i--) {
        int sum = digits[i] + carry; // Add carry to current digit
        result[i + 1] = sum % 10;    // Store current digit
        carry = sum / 10;             // Update carry
    }

    // If there is a leftover carry, put it at the front
    if (carry > 0) {
        result[0] = carry;
        *returnSize = digitsSize + 1;
        return result;
    } else {
        // No leftover carry, shift result to exclude the first extra space
        for (int i = 0; i < digitsSize; i++) {
            result[i] = result[i + 1];
        }
        *returnSize = digitsSize;
        return result;
    }
}
