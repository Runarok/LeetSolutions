function minDeletionSize(strs: string[]): number {
    const n = strs.length;          // number of rows
    const m = strs[0].length;       // number of columns

    // dp[j] = length of the longest valid column sequence ending at column j
    const dp: number[] = new Array(m).fill(1);

    // Try to extend sequences ending at column i to column j
    for (let j = 0; j < m; j++) {
        for (let i = 0; i < j; i++) {

            // Check if column i can come before column j
            // i.e., for EVERY row, strs[row][i] <= strs[row][j]
            let valid = true;

            for (let row = 0; row < n; row++) {
                if (strs[row][i] > strs[row][j]) {
                    valid = false;
                    break;
                }
            }

            // If valid, update DP
            if (valid) {
                dp[j] = Math.max(dp[j], dp[i] + 1);
            }
        }
    }

    // Longest sequence of columns we can keep
    const maxKept = Math.max(...dp);

    // Minimum deletions = total columns - columns kept
    return m - maxKept;
}
