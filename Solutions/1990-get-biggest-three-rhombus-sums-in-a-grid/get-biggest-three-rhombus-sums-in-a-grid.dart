class Solution {
  List<int> getBiggestThree(List<List<int>> grid) {
    int m = grid.length;       // number of rows
    int n = grid[0].length;    // number of columns

    // Use a Set so we only keep distinct rhombus sums
    Set<int> sums = {};

    // Iterate through every cell as the center/top of a rhombus
    for (int r = 0; r < m; r++) {
      for (int c = 0; c < n; c++) {

        // Radius = 0 means the rhombus is just the single cell itself
        sums.add(grid[r][c]);

        // Maximum possible radius from this position
        int maxRadius = 1;

        while (true) {
          // Coordinates of the 4 corners of the rhombus
          int topR = r - maxRadius;
          int bottomR = r + maxRadius;
          int leftC = c - maxRadius;
          int rightC = c + maxRadius;

          // If any corner goes out of bounds, stop expanding
          if (topR < 0 || bottomR >= m || leftC < 0 || rightC >= n) break;

          int sum = 0;

          // Traverse edge: top -> right
          int i = topR;
          int j = c;
          for (int k = 0; k < maxRadius; k++) {
            sum += grid[i][j];
            i++;
            j++;
          }

          // Traverse edge: right -> bottom
          i = r;
          j = rightC;
          for (int k = 0; k < maxRadius; k++) {
            sum += grid[i][j];
            i++;
            j--;
          }

          // Traverse edge: bottom -> left
          i = bottomR;
          j = c;
          for (int k = 0; k < maxRadius; k++) {
            sum += grid[i][j];
            i--;
            j--;
          }

          // Traverse edge: left -> top
          i = r;
          j = leftC;
          for (int k = 0; k < maxRadius; k++) {
            sum += grid[i][j];
            i--;
            j++;
          }

          // Add rhombus border sum to set
          sums.add(sum);

          // Try next larger radius
          maxRadius++;
        }
      }
    }

    // Convert set to list so we can sort
    List<int> result = sums.toList();

    // Sort in descending order
    result.sort((a, b) => b.compareTo(a));

    // Return at most the top 3 values
    return result.length > 3 ? result.sublist(0, 3) : result;
  }
}