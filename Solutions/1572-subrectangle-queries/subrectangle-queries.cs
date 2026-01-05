using System;

public class SubrectangleQueries
{
    // Store the rectangle
    private int[][] rect;

    /// <summary>
    /// Initialize with a given rectangle
    /// </summary>
    public SubrectangleQueries(int[][] rectangle)
    {
        // Deep copy to avoid external changes affecting the internal rectangle
        int rows = rectangle.Length;
        int cols = rectangle[0].Length;
        rect = new int[rows][];
        for (int i = 0; i < rows; i++)
        {
            rect[i] = new int[cols];
            Array.Copy(rectangle[i], rect[i], cols);
        }
    }

    /// <summary>
    /// Update all values in the subrectangle [row1,col1] to [row2,col2] with newValue
    /// </summary>
    public void UpdateSubrectangle(int row1, int col1, int row2, int col2, int newValue)
    {
        for (int r = row1; r <= row2; r++)
        {
            for (int c = col1; c <= col2; c++)
            {
                rect[r][c] = newValue;
            }
        }
    }

    /// <summary>
    /// Get the current value at coordinate (row, col)
    /// </summary>
    public int GetValue(int row, int col)
    {
        return rect[row][col];
    }
}

/**
Example Usage:

int[][] rectangle = new int[][] {
    new int[]{1,2,1},
    new int[]{4,3,4},
    new int[]{3,2,1},
    new int[]{1,1,1}
};

SubrectangleQueries sq = new SubrectangleQueries(rectangle);
Console.WriteLine(sq.GetValue(0,2)); // 1
sq.UpdateSubrectangle(0,0,3,2,5);
Console.WriteLine(sq.GetValue(0,2)); // 5
Console.WriteLine(sq.GetValue(3,1)); // 5
sq.UpdateSubrectangle(3,0,3,2,10);
Console.WriteLine(sq.GetValue(3,1)); // 10
Console.WriteLine(sq.GetValue(0,2)); // 5
*/

