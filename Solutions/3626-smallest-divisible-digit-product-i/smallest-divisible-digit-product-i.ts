function smallestNumber(n: number, t: number): number {

    // Keep checking numbers starting from n
    while (true) {

        // Current number we are testing
        let current = n;

        // Product of digits
        let product = 1;

        // Special case:
        // If the number is 0, its digit product is 0.
        if (current === 0) {
            product = 0;
        } else {

            // Multiply every digit
            while (current > 0) {

                // Get the last digit
                const digit = current % 10;

                // Multiply it into the product
                product *= digit;

                // Remove the last digit
                current = Math.floor(current / 10);
            }
        }

        // If product is divisible by t, we found our answer
        if (product % t === 0) {
            return n;
        }

        // Otherwise check the next number
        n++;
    }
}