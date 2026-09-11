function totalNumbers(digits: number[]): number {
    // Store how many times each digit appears.
    const count = new Array(10).fill(0);

    for (const digit of digits) {
        count[digit]++;
    }

    let result = 0;

    // The last digit must be even: 0, 2, 4, 6, or 8.
    for (let last = 0; last <= 8; last += 2) {
        // We cannot use this digit if it doesn't exist.
        if (count[last] === 0) {
            continue;
        }

        // Use one copy of the last digit.
        count[last]--;

        // Choose the hundreds digit.
        // It cannot be 0 because the number must be three-digit.
        for (let first = 1; first <= 9; first++) {
            if (count[first] === 0) {
                continue;
            }

            // Use one copy of the hundreds digit.
            count[first]--;

            // Choose the tens digit.
            // It can be any remaining digit, including 0.
            for (let middle = 0; middle <= 9; middle++) {
                if (count[middle] > 0) {
                    // Every valid choice creates one distinct number.
                    result++;
                }
            }

            // Restore the hundreds digit for the next possibility.
            count[first]++;
        }

        // Restore the last digit for the next even digit.
        count[last]++;
    }

    return result;
}
