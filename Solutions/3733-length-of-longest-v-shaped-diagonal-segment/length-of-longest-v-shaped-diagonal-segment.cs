public class Solution
{
    // Diagonal directions represented as (rowOffset, colOffset):
    // 0 → ↘ (Down-Right), 1 → ↙ (Down-Left), 2 → ↖ (Up-Left), 3 → ↗ (Up-Right)
    private readonly int[][] DIRS = new int[][]
    {
        new int[] { 1, 1 },   // direction 0
        new int[] { 1, -1 },  // direction 1
        new int[] { -1, -1 }, // direction 2
        new int[] { -1, 1 }   // direction 3
    };

    // Memoization array: [row][col][direction][canTurn]
    // - Stores the max path length from a specific state to avoid recomputation
    private int[,,,] memo;

    private int[][] grid; // The input grid (2D matrix of integers)
    private int m, n;     // m = number of rows, n = number of columns

    /// <summary>
    /// Main function that returns the length of the longest "V" shaped diagonal
    /// path that alternates between 1 and 2 and allows one 90° turn.
    /// </summary>
    public int LenOfVDiagonal(int[][] grid)
    {
        // Initialize grid and dimensions
        this.grid = grid;
        m = grid.Length;
        n = grid[0].Length;

        // Initialize memo array to -1 (unvisited state)
        memo = new int[m, n, 4, 2];
        for (int i = 0; i < m; i++)
        {
            for (int j = 0; j < n; j++)
            {
                for (int k = 0; k < 4; k++)
                {
                    for (int l = 0; l < 2; l++)
                    {
                        memo[i, j, k, l] = -1;
                    }
                }
            }
        }

        int res = 0; // Track the maximum path length found

        // Try starting from every cell that contains the number 1
        for (int i = 0; i < m; i++)
        {
            for (int j = 0; j < n; j++)
            {
                if (grid[i][j] == 1)
                {
                    // Explore all 4 diagonal directions from this cell
                    for (int direction = 0; direction < 4; direction++)
                    {
                        // Start DFS from this cell with next expected value = 2
                        // 'true' means a turn is still allowed
                        // '+1' accounts for the starting cell itself
                        res = Math.Max(res, Dfs(i, j, direction, true, 2) + 1);
                    }
                }
            }
        }

        return res; // Return the longest valid diagonal V-path found
    }

    /// <summary>
    /// Recursive DFS to explore diagonal paths from a cell.
    /// </summary>
    /// <param name="cx">Current row position</param>
    /// <param name="cy">Current column position</param>
    /// <param name="direction">Current direction (0 to 3)</param>
    /// <param name="turn">Whether a 90° turn is still allowed</param>
    /// <param name="target">The value we expect at the next cell (1 or 2)</param>
    /// <returns>Max path length starting from this state</returns>
    private int Dfs(int cx, int cy, int direction, bool turn, int target)
    {
        // Compute the next cell's position based on direction
        int nx = cx + DIRS[direction][0];
        int ny = cy + DIRS[direction][1];

        // Stop if out of grid bounds or next value doesn't match the expected
        if (nx < 0 || ny < 0 || nx >= m || ny >= n || grid[nx][ny] != target)
        {
            return 0;
        }

        // Convert the boolean 'turn' flag into an integer index for memo table
        int turnInt = turn ? 1 : 0;

        // If this state was already computed, reuse it
        if (memo[nx, ny, direction, turnInt] != -1)
        {
            return memo[nx, ny, direction, turnInt];
        }

        // Step 1: Continue moving in the same direction, toggling target value (1 <-> 2)
        int maxStep = Dfs(nx, ny, direction, turn, 2 - target);

        // Step 2: If a turn is still allowed, try turning 90° clockwise
        if (turn)
        {
            int newDir = (direction + 1) % 4; // Clockwise turn
            // Continue DFS with 'turn' set to false since we've used it
            maxStep = Math.Max(maxStep, Dfs(nx, ny, newDir, false, 2 - target));
        }

        // Cache and return result (+1 for current cell move)
        memo[nx, ny, direction, turnInt] = maxStep + 1;
        return maxStep + 1;
    }
}
