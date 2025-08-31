public class Solution
{
    // Main function to solve the Sudoku puzzle
    public void SolveSudoku(char[][] board)
    {
        // Start solving from the first cell (0,0)
        Solve(board);
    }

    // Helper method that uses backtracking to solve the board
    private bool Solve(char[][] board)
    {
        // Loop through each row
        for (int row = 0; row < 9; row++)
        {
            // Loop through each column
            for (int col = 0; col < 9; col++)
            {
                // If the current cell is empty (represented by '.')
                if (board[row][col] == '.')
                {
                    // Try all digits from '1' to '9'
                    for (char num = '1'; num <= '9'; num++)
                    {
                        // Check if placing the current number is valid
                        if (IsValid(board, row, col, num))
                        {
                            // Place the number
                            board[row][col] = num;

                            // Recursively try to solve the rest of the board
                            if (Solve(board))
                            {
                                // If it leads to a solution, return true
                                return true;
                            }

                            // If not valid, backtrack and undo the move
                            board[row][col] = '.';
                        }
                    }

                    // If no valid number can be placed in this cell, return false (trigger backtracking)
                    return false;
                }
            }
        }

        // If we reached here, the board is completely filled and valid
        return true;
    }

    // Helper method to check whether placing a number is valid according to Sudoku rules
    private bool IsValid(char[][] board, int row, int col, char num)
    {
        // Check the entire row
        for (int i = 0; i < 9; i++)
        {
            if (board[row][i] == num)
            {
                // The number already exists in this row
                return false;
            }
        }

        // Check the entire column
        for (int i = 0; i < 9; i++)
        {
            if (board[i][col] == num)
            {
                // The number already exists in this column
                return false;
            }
        }

        // Check the 3x3 subgrid
        // Calculate the starting index of the subgrid
        int startRow = (row / 3) * 3;
        int startCol = (col / 3) * 3;

        // Loop through the 3x3 subgrid
        for (int i = startRow; i < startRow + 3; i++)
        {
            for (int j = startCol; j < startCol + 3; j++)
            {
                if (board[i][j] == num)
                {
                    // The number already exists in this subgrid
                    return false;
                }
            }
        }

        // If passed all checks, the number can be placed here
        return true;
    }
}
