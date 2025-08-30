public class Solution {
    public bool IsValidSudoku(char[][] board) {
        // Initialize hash sets for each of the 9 rows, columns, and 3x3 sub-boxes
        HashSet<char>[] rows = new HashSet<char>[9];
        HashSet<char>[] cols = new HashSet<char>[9];
        HashSet<char>[] boxes = new HashSet<char>[9];

        // Create new empty hash sets for all rows, columns, and boxes
        for (int i = 0; i < 9; i++) {
            rows[i] = new HashSet<char>();
            cols[i] = new HashSet<char>();
            boxes[i] = new HashSet<char>();
        }

        // Iterate over every cell in the board
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                char current = board[i][j];

                // Skip empty cells
                if (current == '.') continue;

                // Check if the digit already exists in the current row
                if (rows[i].Contains(current))
                    return false; // Invalid: duplicate in row
                rows[i].Add(current);

                // Check if the digit already exists in the current column
                if (cols[j].Contains(current))
                    return false; // Invalid: duplicate in column
                cols[j].Add(current);

                // Calculate the index of the 3x3 sub-box
                // Sub-box indices:
                // 0 1 2
                // 3 4 5
                // 6 7 8
                int boxIndex = (i / 3) * 3 + (j / 3);

                // Check if the digit already exists in the 3x3 box
                if (boxes[boxIndex].Contains(current))
                    return false; // Invalid: duplicate in sub-box
                boxes[boxIndex].Add(current);
            }
        }

        // All checks passed — the board is valid
        return true;
    }
}
