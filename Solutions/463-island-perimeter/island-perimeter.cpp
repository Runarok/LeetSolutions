class Solution {
public:
    int islandPerimeter(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int perimeter = 0;

        // Iterate through each cell
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1) { // If it's land
                    perimeter += 4; // Start with 4 sides

                    // Check the upper neighbor
                    if (i > 0 && grid[i-1][j] == 1) perimeter -= 2;
                    // Check the left neighbor
                    if (j > 0 && grid[i][j-1] == 1) perimeter -= 2;
                    // Note: Only upper and left neighbors need to be checked
                    // because right and bottom will be handled when we reach them
                }
            }
        }

        return perimeter;
    }
};
