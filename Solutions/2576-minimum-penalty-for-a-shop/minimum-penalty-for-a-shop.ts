function bestClosingTime(customers: string): number {
    // n = total number of hours
    const n = customers.length;

    // ---------------------------------------------
    // IDEA:
    // ---------------------------------------------
    // If the shop closes at hour j:
    //  - Hours [0 ... j-1] are OPEN
    //  - Hours [j ... n-1] are CLOSED
    //
    // Penalty rules:
    // 1) OPEN + 'N'  -> penalty +1
    // 2) CLOSED + 'Y' -> penalty +1
    //
    // We want the earliest j with the minimum penalty.
    // ---------------------------------------------

    // ---------------------------------------------
    // STEP 1: Initial penalty when shop closes at hour 0
    // ---------------------------------------------
    // If we close at hour 0, the shop is CLOSED for ALL hours.
    // So we get a penalty for every 'Y' in the entire string.
    //
    // Example: "YYNY" -> 3 penalties initially
    // ---------------------------------------------
    let penalty = 0;
    for (let c of customers) {
        if (c === 'Y') {
            penalty++;
        }
    }

    // ---------------------------------------------
    // Track the minimum penalty seen so far
    // and the earliest hour that achieves it
    // ---------------------------------------------
    let minPenalty = penalty;
    let bestHour = 0;

    // ---------------------------------------------
    // STEP 2: Try closing at each hour j = 1 to n
    // ---------------------------------------------
    // When we move from closing at (j-1) to closing at j:
    //
    // The (j-1)th hour changes from:
    //   CLOSED -> OPEN
    //
    // If customers[j-1] == 'Y':
    //   - Before: CLOSED + 'Y' = +1 penalty
    //   - After:  OPEN + 'Y'   = 0 penalty
    //   => penalty decreases by 1
    //
    // If customers[j-1] == 'N':
    //   - Before: CLOSED + 'N' = 0 penalty
    //   - After:  OPEN + 'N'   = +1 penalty
    //   => penalty increases by 1
    // ---------------------------------------------
    for (let j = 1; j <= n; j++) {
        const prevHour = customers[j - 1];

        if (prevHour === 'Y') {
            // Removing a "closed with customer" penalty
            penalty--;
        } else {
            // Adding an "open with no customer" penalty
            penalty++;
        }

        // -----------------------------------------
        // Check if this is the best (minimum) penalty
        // -----------------------------------------
        if (penalty < minPenalty) {
            minPenalty = penalty;
            bestHour = j; // earliest hour automatically preserved
        }
    }

    // ---------------------------------------------
    // Return the earliest hour with minimum penalty
    // ---------------------------------------------
    return bestHour;
}
