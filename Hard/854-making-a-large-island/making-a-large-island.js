function largestIsland(grid) {
    const n = grid.length;
    let islandId = 2; // Start labeling islands from 2 (since 0 = water, 1 = land)
    const islandSizes = {}; // Stores size of each island, keyed by its ID

    // Step 1: Assign unique IDs to islands and calculate their sizes
    for (let row = 0; row < n; row++) {
        for (let col = 0; col < n; col++) {
            if (grid[row][col] === 1) {
                // Perform DFS to label the island and calculate its size
                const size = exploreIsland(grid, row, col, islandId);
                islandSizes[islandId] = size;
                islandId++; // Move to the next island ID
            }
        }
    }

    // Step 2: Find the largest island by flipping one 0 to 1
    let maxIslandSize = Math.max(...Object.values(islandSizes), 0); // Get max existing island size

    for (let row = 0; row < n; row++) {
        for (let col = 0; col < n; col++) {
            if (grid[row][col] === 0) {
                const uniqueNeighbors = new Set(); // Stores unique island IDs around this 0

                // Check all four possible neighbors (up, down, left, right)
                for (const [dx, dy] of [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
                    const newRow = row + dx, newCol = col + dy;
                    if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n && grid[newRow][newCol] !== 0) {
                        uniqueNeighbors.add(grid[newRow][newCol]);
                    }
                }

                // Calculate potential island size if this 0 is flipped to 1
                let potentialSize = 1; // The flipped cell itself counts as 1
                for (const island of uniqueNeighbors) {
                    potentialSize += islandSizes[island] || 0; // Add neighboring island sizes
                }

                maxIslandSize = Math.max(maxIslandSize, potentialSize);
            }
        }
    }

    return maxIslandSize;
}

// Helper function to explore an island and assign a unique ID using DFS
function exploreIsland(grid, row, col, islandId) {
    const n = grid.length;

    // Base condition: Stop DFS if out of bounds or if it's not land (1)
    if (row < 0 || row >= n || col < 0 || col >= n || grid[row][col] !== 1) {
        return 0;
    }

    grid[row][col] = islandId; // Mark this land cell with the island ID
    let islandSize = 1; // Start counting the size of the island

    // Explore in all four directions (up, down, left, right)
    islandSize += exploreIsland(grid, row + 1, col, islandId);
    islandSize += exploreIsland(grid, row - 1, col, islandId);
    islandSize += exploreIsland(grid, row, col + 1, islandId);
    islandSize += exploreIsland(grid, row, col - 1, islandId);

    return islandSize; // Return total size of the explored island
}
