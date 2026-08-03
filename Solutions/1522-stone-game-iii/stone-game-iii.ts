function stoneGameIII(stoneValue: number[]): string {
    const n = stoneValue.length;

    // dp[i] = maximum score difference the current player
    // can achieve starting from index i.
    //
    // Difference = (current player's score) - (other player's score)
    //
    // We make dp size n + 3 so that dp[i+1], dp[i+2], dp[i+3]
    // are always valid without checking bounds.
    const dp = new Array(n + 3).fill(0);

    // Build the DP table from the end of the array.
    // At the end (i >= n), score difference is 0 because
    // there are no stones left.
    for (let i = n - 1; i >= 0; i--) {

        // This stores the total value of stones taken
        // in the current choice.
        let take = 0;

        // Initialize with a very small number because
        // we are looking for the maximum score difference.
        dp[i] = -Infinity;

        // Try taking 1, 2, and 3 stones.
        for (let k = 0; k < 3 && i + k < n; k++) {

            // Add the value of the next stone.
            take += stoneValue[i + k];

            // After taking (k+1) stones,
            // the opponent starts from index (i+k+1).
            //
            // dp[i+k+1] is the opponent's best score difference.
            //
            // Since that advantage belongs to the opponent,
            // subtract it from our current gain.
            const currentDifference = take - dp[i + k + 1];

            // Choose the move that gives us the largest advantage.
            dp[i] = Math.max(dp[i], currentDifference);
        }
    }

    // Interpret the final score difference.
    if (dp[0] > 0) return "Alice";
    if (dp[0] < 0) return "Bob";
    return "Tie";
}