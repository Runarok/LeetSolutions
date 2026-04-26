public class Solution {
    public bool ContainsCycle(char[][] grid) {
        int m = grid.Length;
        int n = grid[0].Length;

        // Visited array to keep track of visited cells
        bool[,] visited = new bool[m, n];

        // Traverse every cell in the grid
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {

                // If this cell is not visited, start DFS
                if (!visited[i, j]) {

                    // If DFS finds a cycle, return true immediately
                    if (DFS(grid, visited, i, j, -1, -1)) {
                        return true;
                    }
                }
            }
        }

        // If no cycle found anywhere
        return false;
    }

    private bool DFS(char[][] grid, bool[,] visited, int row, int col, int prevRow, int prevCol) {
        int m = grid.Length;
        int n = grid[0].Length;

        // Mark current cell as visited
        visited[row, col] = true;

        // Directions: up, down, left, right
        int[] dr = new int[] { -1, 1, 0, 0 };
        int[] dc = new int[] { 0, 0, -1, 1 };

        // Explore all 4 directions
        for (int d = 0; d < 4; d++) {
            int newRow = row + dr[d];
            int newCol = col + dc[d];

            // Check boundaries
            if (newRow < 0 || newRow >= m || newCol < 0 || newCol >= n)
                continue;

            // Only consider same character cells
            if (grid[newRow][newCol] != grid[row][col])
                continue;

            // If the next cell is the previous cell, skip it
            if (newRow == prevRow && newCol == prevCol)
                continue;

            // If already visited and not parent → cycle detected
            if (visited[newRow, newCol])
                return true;

            // Otherwise continue DFS
            if (DFS(grid, visited, newRow, newCol, row, col))
                return true;
        }

        // No cycle found from this path
        return false;
    }
}