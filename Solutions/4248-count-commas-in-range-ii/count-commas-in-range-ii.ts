function countCommas(n: number): number {
    // We will store the total number of commas here.
    let total = 0;

    // 'power' represents the size of each comma-separated group.
    //
    // power = 1,000:
    // Every number from 1,000 onwards has at least 1 comma.
    //
    // power = 1,000,000:
    // Every number from 1,000,000 onwards has at least 2 commas.
    //
    // power = 1,000,000,000:
    // Every number from 1,000,000,000 onwards has at least 3 commas.
    //
    // And so on.
    let power = 1000;

    // For every power of 1000, count how many numbers
    // from 1 to n have a comma at this particular position.
    while (power <= n) {
        // All numbers >= power contain a comma at this level.
        //
        // Example:
        // n = 1002, power = 1000
        //
        // There are:
        // 1002 - 1000 + 1 = 3
        // numbers: 1000, 1001, 1002
        //
        // Each contributes one comma.
        total += n - power + 1;

        // Move to the next comma position.
        //
        // 1,000 -> 1,000,000 -> 1,000,000,000 ...
        power *= 1000;
    }

    // Return the total number of commas.
    return total;
}
