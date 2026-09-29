function hasValidPath(grid: string[][]): boolean {
    const m = grid.length;
    const n = grid[0].length;
    const totalLength = m + n - 1;

    // 1. Path length must be even, start with '(', and end with ')'
    if (totalLength % 2 !== 0 || grid[0][0] === ')' || grid[m - 1][n - 1] === '(') {
        return false;
    }

    const maxBalance = Math.floor(totalLength / 2);

    // dp[r][c] stores a boolean array where index 'b' is true if balance 'b' is reachable at (r, c)
    const dp: boolean[][][] = Array.from({ length: m }, () =>
        Array.from({ length: n }, () => new Array(maxBalance + 1).fill(false))
    );

    // Initial state at (0, 0)
    dp[0][0][1] = true;

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (r === 0 && c === 0) continue;

            const diff = grid[r][c] === '(' ? 1 : -1;

            // Collect reachable balances from top and left neighbors
            for (let b = 0; b <= maxBalance; b++) {
                const comesFromTop = r > 0 && dp[r - 1][c][b];
                const comesFromLeft = c > 0 && dp[r][c - 1][b];

                if (comesFromTop || comesFromLeft) {
                    const nextBalance = b + diff;
                    if (nextBalance >= 0 && nextBalance <= maxBalance) {
                        dp[r][c][nextBalance] = true;
                    }
                }
            }
        }
    }

    // Check if balance 0 is reachable at the bottom-right cell
    return dp[m - 1][n - 1][0];
}