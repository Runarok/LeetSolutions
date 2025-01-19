/**
 * @param {number[][]} heightMap
 * @return {number}
 */
var trapRainWater = function(heightMap) {
    if (!heightMap || heightMap.length === 0 || heightMap[0].length === 0) return 0;

    const m = heightMap.length;
    const n = heightMap[0].length;
    let totalWater = 0;
    
    // Min-heap (priority queue) and visited set
    const minHeap = [];
    const visited = Array.from({ length: m }, () => Array(n).fill(false));

    // Add all boundary cells to the heap and mark them as visited
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 || j === 0 || i === m - 1 || j === n - 1) {
                minHeap.push([heightMap[i][j], i, j]);
                visited[i][j] = true;
            }
        }
    }

    // Convert the minHeap into a valid heap structure
    minHeap.sort((a, b) => a[0] - b[0]);

    // Directions for the 4 possible neighbors
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    // Process the heap
    while (minHeap.length > 0) {
        const [height, x, y] = minHeap.shift(); // Pop the smallest height
        
        // Explore all neighbors
        for (let [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            
            // Ensure the neighbor is within bounds and not visited
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                // If the neighbor is lower, calculate the trapped water
                if (heightMap[nx][ny] < height) {
                    totalWater += height - heightMap[nx][ny];
                }
                // Mark the neighbor as visited
                visited[nx][ny] = true;
                // Push the neighbor into the heap with the max height (to maintain water flow)
                minHeap.push([Math.max(heightMap[nx][ny], height), nx, ny]);
            }
        }
        
        // Keep the heap sorted after each operation
        minHeap.sort((a, b) => a[0] - b[0]);
    }

    return totalWater;
};
