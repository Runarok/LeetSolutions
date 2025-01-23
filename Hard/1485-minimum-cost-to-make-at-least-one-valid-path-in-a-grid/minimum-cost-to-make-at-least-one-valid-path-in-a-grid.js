/**
 * @param {number[][]} grid
 * @return {number}
 */
var minCost = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    
    // Directions: right, left, down, up
    const directions = [
        [0, 1],  // right
        [0, -1], // left
        [1, 0],  // down
        [-1, 0], // up
    ];
    
    // Check if there is already a valid path with no changes
    const isValidPath = () => {
        const visited = Array.from({ length: m }, () => Array(n).fill(false));
        const queue = [[0, 0]];
        visited[0][0] = true;
        
        while (queue.length > 0) {
            const [x, y] = queue.shift();
            const dir = grid[x][y] - 1;
            const [dx, dy] = directions[dir];
            const nx = x + dx;
            const ny = y + dy;
            
            if (nx === m - 1 && ny === n - 1) return true; // If we reach bottom-right, return true
            if (nx >= 0 && ny >= 0 && nx < m && ny < n && !visited[nx][ny]) {
                visited[nx][ny] = true;
                queue.push([nx, ny]);
            }
        }
        
        return false;
    };

    // If a valid path exists without any changes, return 0
    if (isValidPath()) {
        return 0;
    }

    // If no valid path, we use a modified BFS or priority queue approach to find the minimum cost.
    const cost = Array.from({ length: m }, () => Array(n).fill(Infinity));
    cost[0][0] = 0;
    const pq = [[0, 0, 0]]; // (cost, x, y)
    
    while (pq.length > 0) {
        // Pop the cell with the smallest cost
        pq.sort((a, b) => a[0] - b[0]);
        const [curCost, x, y] = pq.shift();
        
        // If we've reached the bottom-right corner, return the cost
        if (x === m - 1 && y === n - 1) {
            return curCost;
        }

        // Try to follow the current direction (do not change it)
        const curDir = grid[x][y] - 1;
        const [dx, dy] = directions[curDir];
        const nx = x + dx;
        const ny = y + dy;

        // If within bounds and following the sign is cheaper, update
        if (nx >= 0 && ny >= 0 && nx < m && ny < n && curCost < cost[nx][ny]) {
            cost[nx][ny] = curCost;
            pq.push([curCost, nx, ny]);
        }

        // Now, consider changing the sign (each change costs 1)
        for (let i = 0; i < 4; i++) {
            if (i === curDir) continue; // Skip the current direction
            
            const [dx, dy] = directions[i];
            const nx = x + dx;
            const ny = y + dy;
            
            if (nx >= 0 && ny >= 0 && nx < m && ny < n && curCost + 1 < cost[nx][ny]) {
                cost[nx][ny] = curCost + 1;
                pq.push([curCost + 1, nx, ny]);
            }
        }
    }

    return -1; // In case there's no path (though this case shouldn't happen in a valid grid).
};
