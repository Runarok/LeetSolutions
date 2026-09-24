function smallestIndex(nums: number[]): number {
    // Go through every index in the array from left to right.
    // Since we start at index 0, the first matching index
    // we find will automatically be the smallest one.
    for (let i = 0; i < nums.length; i++) {
        // Store the current number.
        let num = nums[i];

        // This variable will hold the sum of all digits
        // in the current number.
        let digitSum = 0;

        // Special case: if the number is 0,
        // its digit sum is also 0.
        if (num === 0) {
            digitSum = 0;
        } else {
            // Extract each digit from the number.
            //
            // Example:
            // num = 123
            //
            // 123 % 10 = 3  -> last digit
            // 123 / 10 = 12
            //
            // 12 % 10 = 2   -> next digit
            // 12 / 10 = 1
            //
            // 1 % 10 = 1    -> last digit
            // 1 / 10 = 0
            //
            // Then the loop stops.
            while (num > 0) {
                // Get the last digit using modulo 10.
                digitSum += num % 10;

                // Remove the last digit.
                //
                // Math.floor() is used because JavaScript's
                // normal division produces a decimal number.
                num = Math.floor(num / 10);
            }
        }

        // Check whether the sum of the digits
        // is equal to the current index.
        if (digitSum === i) {
            // Because we are checking indices from left to right,
            // this is guaranteed to be the smallest valid index.
            return i;
        }
    }

    // If we finish checking the entire array and
    // never find a matching index, return -1.
    return -1;
}
