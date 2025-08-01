class Solution {
  List<List<int>> generate(int numRows) {
    // This will hold all rows of Pascal's Triangle
    List<List<int>> triangle = [];

    // Loop to build each row of the triangle
    for (int i = 0; i < numRows; i++) {
      // Create a new row with (i + 1) elements, all initialized to 1
      List<int> row = List.filled(i + 1, 1);

      // Compute values for the middle elements of the row
      // (Skip the first and last elements, which are always 1)
      for (int j = 1; j < i; j++) {
        // Each element is the sum of the two elements above it
        row[j] = triangle[i - 1][j - 1] + triangle[i - 1][j];
      }

      // Add the completed row to the triangle
      triangle.add(row);
    }

    // Return the completed Pascal's Triangle
    return triangle;
  }
}
