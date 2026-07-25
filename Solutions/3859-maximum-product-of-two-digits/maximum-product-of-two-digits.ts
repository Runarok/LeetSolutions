function maxProduct(n: number): number {
    // Store the largest digit found so far.
    let largest = -1;

    // Store the second largest digit found so far.
    let secondLargest = -1;

    // Continue until every digit has been processed.
    while (n > 0) {
        // Get the last digit of the number.
        const digit = n % 10;

        // If this digit is greater than or equal to the current largest,
        // move the old largest into secondLargest.
        //
        // We use >= instead of > so duplicate digits (like 22 or 99)
        // are handled correctly.
        if (digit >= largest) {
            secondLargest = largest;
            largest = digit;
        }
        // Otherwise, if it's not the largest but is bigger than the
        // current second largest, update secondLargest.
        else if (digit > secondLargest) {
            secondLargest = digit;
        }

        // Remove the last digit and continue.
        n = Math.floor(n / 10);
    }

    // The answer is the product of the two largest digits.
    return largest * secondLargest;
}