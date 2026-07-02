function maximumSafenessFactor(grid: number[][]): number {
    const n = grid.length;

    // Directions for moving in the grid
    const dirs = [
        [1, 0],
        [-1, 0],
        [0, 1],
        [0, -1]
    ];

    // ---------------------------------------------------------
    // STEP 1:
    // Compute the distance of every cell to its nearest thief.
    //
    // We do this using Multi-Source BFS:
    // Put every thief into the queue initially.
    // Their distance is 0.
    //
    // Then expand simultaneously.
    //
    // This guarantees the first time we visit a cell is the
    // shortest distance to ANY thief.
    // ---------------------------------------------------------

    const dist: number[][] = Array.from({ length: n }, () =>
        Array(n).fill(-1)
    );

    const queue: number[][] = [];
    let head = 0;

    // Add every thief into the BFS queue
    for (let r = 0; r < n; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                dist[r][c] = 0;
                queue.push([r, c]);
            }
        }
    }

    // Multi-source BFS
    while (head < queue.length) {
        const [r, c] = queue[head++];

        for (const [dr, dc] of dirs) {
            const nr = r + dr;
            const nc = c + dc;

            // Outside grid
            if (nr < 0 || nr >= n || nc < 0 || nc >= n) continue;

            // Already visited
            if (dist[nr][nc] !== -1) continue;

            dist[nr][nc] = dist[r][c] + 1;
            queue.push([nr, nc]);
        }
    }

    // ---------------------------------------------------------
    // STEP 2:
    // Binary search the answer.
    //
    // If we can make a path with safeness = X,
    // then every value <= X is also possible.
    //
    // Therefore answer is monotonic.
    // ---------------------------------------------------------

    let left = 0;
    let right = 2 * (n - 1);

    // ---------------------------------------------------------
    // Checks if we can travel from (0,0) to (n-1,n-1)
    // while every visited cell has distance >= limit.
    // ---------------------------------------------------------
    function can(limit: number): boolean {
        // Start cell already violates the condition
        if (dist[0][0] < limit) return false;

        const visited: boolean[][] = Array.from({ length: n }, () =>
            Array(n).fill(false)
        );

        const q: number[][] = [[0, 0]];
        let ptr = 0;
        visited[0][0] = true;

        while (ptr < q.length) {
            const [r, c] = q[ptr++];

            // Reached destination
            if (r === n - 1 && c === n - 1) {
                return true;
            }

            for (const [dr, dc] of dirs) {
                const nr = r + dr;
                const nc = c + dc;

                if (nr < 0 || nr >= n || nc < 0 || nc >= n) continue;
                if (visited[nr][nc]) continue;

                // Cell is too close to a thief
                if (dist[nr][nc] < limit) continue;

                visited[nr][nc] = true;
                q.push([nr, nc]);
            }
        }

        return false;
    }

    // Standard binary search for maximum valid answer
    while (left < right) {
        const mid = Math.floor((left + right + 1) / 2);

        if (can(mid)) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}