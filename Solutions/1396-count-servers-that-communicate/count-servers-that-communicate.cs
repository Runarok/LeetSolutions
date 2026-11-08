
public class Solution {
    public int CountServers(int[][] grid) {

        // Get the number of rows in the grid
        int m = grid.Length;

        // Get the number of columns in the grid
        int n = grid[0].Length;

        // Array to store the number of servers in each row
        int[] rowCount = new int[m];

        // Array to store the number of servers in each column
        int[] colCount = new int[n];


        // STEP 1: Count servers in every row and column
        for (int i = 0; i < m; i++) {

            for (int j = 0; j < n; j++) {

                // Check if the current cell contains a server
                if (grid[i][j] == 1) {

                    // Increase the server count for this row
                    rowCount[i]++;

                    // Increase the server count for this column
                    colCount[j]++;
                }
            }
        }


        // Variable to store the total number of
        // servers that can communicate with another server
        int result = 0;


        // STEP 2: Traverse the grid again
        for (int i = 0; i < m; i++) {

            for (int j = 0; j < n; j++) {

                // Check if the current cell contains a server
                if (grid[i][j] == 1) {

                    // A server can communicate if:
                    // 1. There is more than one server in its row
                    // OR
                    // 2. There is more than one server in its column

                    if (rowCount[i] > 1 || colCount[j] > 1) {

                        // This server can communicate with another server
                        result++;
                    }
                }
            }
        }


        // Return the total number of communicating servers
        return result;
    }
}
