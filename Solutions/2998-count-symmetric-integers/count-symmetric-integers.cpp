class Solution {
public:
    int countSymmetricIntegers(int low, int high) {
        int count = 0; // This will store the number of symmetric integers

        // Iterate through all numbers from low to high
        for (int num = low; num <= high; ++num) {
            int temp = num;
            int digits = 0;

            // Step 1: Count the number of digits in the number
            // This is important because symmetric integers must have an even number of digits
            while (temp > 0) {
                temp /= 10;
                digits++;
            }

            // Step 2: Skip numbers with an odd number of digits
            // Symmetric integers must have an even number of digits to split them evenly
            if (digits % 2 != 0) continue;

            // Step 3: Initialize variables to store sum of left and right halves
            int leftSum = 0, rightSum = 0;
            int half = digits / 2;
            temp = num; // Reset temp to original number

            // Step 4: Extract digits from right to left
            // We'll process digits one by one using modulo and integer division
            // We keep track of index to know whether a digit belongs to the left or right half
            for (int i = 0; i < digits; ++i) {
                int digit = temp % 10; // Extract the rightmost digit
                temp /= 10;            // Remove the last digit

                if (i < half) {
                    // First half of digits from the right: this is the "right half" of the number
                    // because we are processing digits in reverse
                    rightSum += digit;
                } else {
                    // Second half of digits from the right: corresponds to the "left half" of the number
                    leftSum += digit;
                }
            }

            // Step 5: Check if the sum of left and right halves are equal
            if (leftSum == rightSum) {
                count++; // Found a symmetric integer
            }
        }

        // Step 6: Return the total count of symmetric integers in the range
        return count;
    }
};