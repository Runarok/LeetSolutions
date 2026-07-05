function pathsWithMaxScore(board: string[]): number[] {
    const n = board.length;
    const MOD = 1000000007;

    // score[r][c] = maximum score from this cell to S
    const score: number[][] = Array.from({ length: n }, () =>
        Array(n).fill(-1)
    );

    // ways[r][c] = number of maximum-score paths
    const ways: number[][] = Array.from({ length: n }, () =>
        Array(n).fill(0)
    );

    // Starting position (S)
    score[n - 1][n - 1] = 0;
    ways[n - 1][n - 1] = 1;

    // Traverse from bottom-right toward top-left
    for (let r = n - 1; r >= 0; r--) {
        for (let c = n - 1; c >= 0; c--) {

            // Skip blocked cells
            if (board[r][c] === 'X')
                continue;

            // Skip S because it's already initialized
            if (r === n - 1 && c === n - 1)
                continue;

            let bestScore = -1;
            let count = 0;

            // Possible previous DP states
            const directions = [
                [1, 0], // down
                [0, 1], // right
                [1, 1], // diagonal
            ];

            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;

                // Outside grid
                if (nr >= n || nc >= n)
                    continue;

                // Unreachable cell
                if (score[nr][nc] === -1)
                    continue;

                // Better score found
                if (score[nr][nc] > bestScore) {
                    bestScore = score[nr][nc];
                    count = ways[nr][nc];
                }
                // Same best score
                else if (score[nr][nc] === bestScore) {
                    count = (count + ways[nr][nc]) % MOD;
                }
            }

            // No reachable neighbour
            if (bestScore === -1)
                continue;

            // Add current cell value
            let value = 0;

            // E and S contribute 0
            if (
                board[r][c] !== 'E' &&
                board[r][c] !== 'S'
            ) {
                value = Number(board[r][c]);
            }

            score[r][c] = bestScore + value;
            ways[r][c] = count;
        }
    }

    // No path exists
    if (ways[0][0] === 0)
        return [0, 0];

    return [score[0][0], ways[0][0]];
}