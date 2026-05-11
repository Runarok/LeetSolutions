public class Solution {
    public int[][] RotateGrid(int[][] grid, int k) {
        int m = grid.Length;
        int n = grid[0].Length;

        int layers = Math.Min(m, n) / 2;

        for (int layer = 0; layer < layers; layer++) {
            List<int> elements = new List<int>();

            int top = layer;
            int left = layer;
            int bottom = m - layer - 1;
            int right = n - layer - 1;

            // Top row
            for (int j = left; j <= right; j++)
                elements.Add(grid[top][j]);

            // Right column
            for (int i = top + 1; i <= bottom - 1; i++)
                elements.Add(grid[i][right]);

            // Bottom row
            for (int j = right; j >= left; j--)
                elements.Add(grid[bottom][j]);

            // Left column
            for (int i = bottom - 1; i >= top + 1; i--)
                elements.Add(grid[i][left]);

            int len = elements.Count;
            int rotate = k % len;

            // Counter-clockwise rotation
            List<int> rotated = new List<int>();

            for (int i = 0; i < len; i++) {
                rotated.Add(elements[(i + rotate) % len]);
            }

            int idx = 0;

            // Fill Top row
            for (int j = left; j <= right; j++)
                grid[top][j] = rotated[idx++];

            // Fill Right column
            for (int i = top + 1; i <= bottom - 1; i++)
                grid[i][right] = rotated[idx++];

            // Fill Bottom row
            for (int j = right; j >= left; j--)
                grid[bottom][j] = rotated[idx++];

            // Fill Left column
            for (int i = bottom - 1; i >= top + 1; i--)
                grid[i][left] = rotated[idx++];
        }

        return grid;
    }
}