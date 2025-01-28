/**
 * @param {number[][]} grid
 * @return {number}
 */
var findMaxFish = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    
    // Direction vectors for moving up, down, left, and right
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    
    // Helper function for performing DFS
    const dfs = (r, c, visited) => {
        let fishCount = grid[r][c];
        visited[r][c] = true;
        
        for (const [dr, dc] of directions) {
            const nr = r + dr, nc = c + dc;
            
            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] > 0 && !visited[nr][nc]) {
                fishCount += dfs(nr, nc, visited);
            }
        }
        
        return fishCount;
    };
    
    let maxFish = 0;
    const visited = Array.from({ length: m }, () => Array(n).fill(false));
    
    // Iterate through all cells in the grid
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] > 0 && !visited[r][c]) {
                // Start a DFS to collect fish from this water cell
                maxFish = Math.max(maxFish, dfs(r, c, visited));
            }
        }
    }
    
    return maxFish;
};
