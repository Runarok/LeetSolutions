function stoneGame(piles: number[]): boolean {
    // Number of piles
    const n = piles.length;

    // dp[i][j] represents the maximum score DIFFERENCE
    // the current player can achieve over the opponent
    // considering only piles from i to j.
    const dp: number[][] = Array.from({ length: n }, () =>
        Array(n).fill(0)
    );

    // Base case:
    // If there is only one pile, the current player simply takes it.
    for (let i = 0; i < n; i++) {
        dp[i][i] = piles[i];
    }

    // Consider all possible subarray lengths
    // Start from length 2 because length 1 is already filled.
    for (let len = 2; len <= n; len++) {

        // Slide the window across the array
        for (let i = 0; i <= n - len; i++) {

            // Ending index
            const j = i + len - 1;

            // Option 1:
            // Take the left pile.
            //
            // After taking piles[i], the opponent plays optimally
            // on the remaining interval (i+1 ... j).
            //
            // Since dp stores score difference,
            // subtract opponent's best advantage.
            const takeLeft = piles[i] - dp[i + 1][j];

            // Option 2:
            // Take the right pile.
            const takeRight = piles[j] - dp[i][j - 1];

            // Choose the move that gives the larger advantage.
            dp[i][j] = Math.max(takeLeft, takeRight);
        }
    }

    // Positive difference means Alice gets more stones.
    return dp[0][n - 1] > 0;
}