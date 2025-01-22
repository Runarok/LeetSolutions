/**
 * @param {number[][]} isWater
 * @return {number[][]}
 */
var highestPeak = function(isWater) {
    const m = isWater.length;
    const n = isWater[0].length;
    
    // Initialize the height matrix with -1 for all land cells.
    const height = Array.from({ length: m }, () => Array(n).fill(-1));
    
    // BFS queue initialization
    const queue = [];
    
    // Step 1: Add all water cells to the queue and set their height to 0
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (isWater[i][j] === 1) {
                height[i][j] = 0;
                queue.push([i, j]);
            }
        }
    }
    
    // Directions for adjacent cells: (up, down, left, right)
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    
    // Step 2: BFS to propagate the heights
    let index = 0; // Instead of shift(), we use a pointer for queue processing
    while (index < queue.length) {
        const [x, y] = queue[index++];
        
        // Check all four possible directions
        for (let [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            
            // If the neighbor is within bounds and is a land cell that hasn't been assigned a height
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && height[nx][ny] === -1) {
                height[nx][ny] = height[x][y] + 1;
                queue.push([nx, ny]);
            }
        }
    }
    
    return height;
};
