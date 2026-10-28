
using System;
using System.Collections.Generic;

public class Solution
{
    public int MinCost(int[][] grid)
    {
        // Get the number of rows and columns in the grid.
        int m = grid.Length;
        int n = grid[0].Length;

        // dp[i, j] stores ALL possible XOR values of paths
        // that start at (0, 0) and end at cell (i, j).
        //
        // We use a HashSet because multiple paths can produce
        // the same XOR value, and we only need to store it once.
        HashSet<int>[,] dp = new HashSet<int>[m, n];

        // Initialize every cell with an empty HashSet.
        // This ensures we can safely add XOR values to any cell.
        for (int i = 0; i < m; i++)
        {
            for (int j = 0; j < n; j++)
            {
                dp[i, j] = new HashSet<int>();
            }
        }

        // The starting cell contributes its value to the path XOR.
        dp[0, 0].Add(grid[0][0]);

        // Process each cell from top to bottom and left to right.
        for (int i = 0; i < m; i++)
        {
            for (int j = 0; j < n; j++)
            {
                // Skip the starting cell because it is already initialized.
                if (i == 0 && j == 0)
                {
                    continue;
                }

                // If we can move down into this cell,
                // copy every possible XOR from the cell above
                // and XOR it with the current cell's value.
                if (i > 0)
                {
                    foreach (int previousXor in dp[i - 1, j])
                    {
                        int currentXor = previousXor ^ grid[i][j];

                        // Save this possible path XOR.
                        dp[i, j].Add(currentXor);
                    }
                }

                // If we can move right into this cell,
                // copy every possible XOR from the cell to the left
                // and XOR it with the current cell's value.
                if (j > 0)
                {
                    foreach (int previousXor in dp[i, j - 1])
                    {
                        int currentXor = previousXor ^ grid[i][j];

                        // Save this possible path XOR.
                        dp[i, j].Add(currentXor);
                    }
                }
            }
        }

        // We have now calculated every possible XOR value
        // for paths reaching the bottom-right cell.
        //
        // Return the smallest XOR value among those possibilities.
        int answer = int.MaxValue;

        foreach (int xorValue in dp[m - 1, n - 1])
        {
            answer = Math.Min(answer, xorValue);
        }

        return answer;
    }
}
