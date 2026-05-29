function minElement(nums: number[]): number {
    // Variable to store the minimum digit sum found
    let minValue = Infinity;

    // Loop through every number in the array
    for (let num of nums) {

        // Store original number in a temporary variable
        let temp = num;

        // Variable to store sum of digits
        let digitSum = 0;

        // Extract digits one by one
        while (temp > 0) {

            // Get last digit using modulo
            let digit = temp % 10;

            // Add digit to sum
            digitSum += digit;

            // Remove last digit
            temp = Math.floor(temp / 10);
        }

        // Update minimum value if current digit sum is smaller
        if (digitSum < minValue) {
            minValue = digitSum;
        }
    }

    // Return the smallest digit sum
    return minValue;
}