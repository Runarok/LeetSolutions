public class Solution {
    public int[][] SortMatrix(int[][] grid) {
        int n = grid.Length;

        // Sort diagonals starting from the first column (bottom-left to top-right)
        for (int row = 0; row < n; row++) {
            List<int> diagonal = new List<int>();
            
            // Collect the diagonal starting at (row, 0)
            for (int i = 0; row + i < n; i++) {
                diagonal.Add(grid[row + i][i]);
            }

            // Sort in descending order (you can change this to ascending if needed)
            diagonal.Sort((a, b) => b.CompareTo(a));

            // Write back the sorted diagonal
            for (int i = 0; row + i < n; i++) {
                grid[row + i][i] = diagonal[i];
            }
        }

        // Sort diagonals starting from the top row (excluding the very first one)
        for (int col = 1; col < n; col++) {
            List<int> diagonal = new List<int>();
            
            // Collect the diagonal starting at (0, col)
            for (int i = 0; col + i < n; i++) {
                diagonal.Add(grid[i][col + i]);
            }

            // Sort in ascending order (you can change this to descending if needed)
            diagonal.Sort();  // ascending

            // Write back the sorted diagonal
            for (int i = 0; col + i < n; i++) {
                grid[i][col + i] = diagonal[i];
            }
        }

        return grid;
    }
}
