public class Solution {
    public char[][] RotateTheBox(char[][] boxGrid) {
        int m = boxGrid.Length;        // number of rows
        int n = boxGrid[0].Length;     // number of columns

        // STEP 1: Simulate gravity (stones fall to the RIGHT)
        // We process each row independently
        for (int i = 0; i < m; i++) {
            
            // 'empty' represents the rightmost available position
            // where a stone can fall within the current segment
            int empty = n - 1;

            // Traverse from right to left
            for (int j = n - 1; j >= 0; j--) {

                // If we encounter an obstacle
                if (boxGrid[i][j] == '*') {
                    // Reset empty pointer to just left of obstacle
                    empty = j - 1;
                }

                // If we encounter a stone
                else if (boxGrid[i][j] == '#') {
                    // Move the stone to the 'empty' position
                    char temp = boxGrid[i][empty];
                    boxGrid[i][empty] = '#';
                    boxGrid[i][j] = temp;

                    // Move empty pointer left
                    empty--;
                }

                // If it's '.', do nothing
            }
        }

        // STEP 2: Rotate the matrix 90 degrees clockwise
        char[][] result = new char[n][];

        for (int i = 0; i < n; i++) {
            result[i] = new char[m];
        }

        // Perform rotation
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                // Map old position (i, j) to new position
                result[j][m - 1 - i] = boxGrid[i][j];
            }
        }

        return result;
    }
}