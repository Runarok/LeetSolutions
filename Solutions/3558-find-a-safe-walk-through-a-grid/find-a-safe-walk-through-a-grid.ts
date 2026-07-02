function findSafeWalk(grid: number[][], health: number): boolean {
    const m = grid.length;
    const n = grid[0].length;

    // -------------------------------------------------------
    // Directions for moving in the grid
    // -------------------------------------------------------
    const dirs = [
        [1, 0],
        [-1, 0],
        [0, 1],
        [0, -1]
    ];

    // -------------------------------------------------------
    // dist[r][c] =
    // Minimum health lost to reach cell (r, c)
    //
    // Initialize every cell with Infinity.
    // -------------------------------------------------------
    const dist: number[][] = Array.from({ length: m }, () =>
        Array(n).fill(Infinity)
    );

    // -------------------------------------------------------
    // Starting health loss.
    //
    // If starting cell is unsafe, we immediately lose 1 health.
    // -------------------------------------------------------
    dist[0][0] = grid[0][0];

    // -------------------------------------------------------
    // 0-1 BFS
    //
    // We use a deque.
    //
    // Moving into:
    //   safe cell   -> cost 0 -> push to FRONT
    //   unsafe cell -> cost 1 -> push to BACK
    //
    // JavaScript doesn't have a deque, so we simulate one
    // using an array with head/tail indices.
    // -------------------------------------------------------

    const size = m * n * 2 + 5;
    const deque: number[][] = new Array(size);

    let front = Math.floor(size / 2);
    let back = front;

    deque[back] = [0, 0];

    while (front <= back) {
        // Pop from front
        const [r, c] = deque[front++];

        // Explore all 4 neighbours
        for (const [dr, dc] of dirs) {
            const nr = r + dr;
            const nc = c + dc;

            // Outside grid
            if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                continue;
            }

            // Cost of entering neighbour
            const cost = grid[nr][nc];

            // New health loss if we go there
            const newLoss = dist[r][c] + cost;

            // Already have a better route
            if (newLoss >= dist[nr][nc]) {
                continue;
            }

            // Found a better route
            dist[nr][nc] = newLoss;

            if (cost === 0) {
                // Cost 0 edges go to the FRONT
                deque[--front] = [nr, nc];
            } else {
                // Cost 1 edges go to the BACK
                deque[++back] = [nr, nc];
            }
        }
    }

    // -------------------------------------------------------
    // We must finish with health >= 1.
    //
    // Remaining health =
    // health - minimumHealthLost
    //
    // health - loss >= 1
    //
    // => loss < health
    // -------------------------------------------------------
    return dist[m - 1][n - 1] < health;
}