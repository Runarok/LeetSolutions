class Solution {

  // This function counts how many "special positions" are in the matrix.
  // A position is considered "special" if:
  // 1. The value at that position is 1
  // 2. It is the ONLY 1 in its row
  // 3. It is the ONLY 1 in its column
  int numSpecial(List<List<int>> mat) {

    // Map to store how many 1s appear in each row.
    // Key   -> row index
    // Value -> count of 1s in that row
    final row = <int, int>{};

    // Map to store how many 1s appear in each column.
    // Key   -> column index
    // Value -> count of 1s in that column
    final col = <int, int>{};

    // This will store the total number of special positions found.
    int special = 0;

    // -----------------------------
    // FIRST PASS: Count all 1s
    // -----------------------------
    // We iterate through the entire matrix to count
    // how many 1s are in each row and each column.

    for (int r = 0; r < mat.length; ++r) {
      // Loop through each column in the current row
      for (int c = 0; c < mat[r].length; ++c) {

        // If the current cell contains a 1
        if (mat[r][c] == 1) {

          // Increase the count for this row.
          // If row[r] doesn't exist yet, use 0 as default.
          row[r] = (row[r] ?? 0) + 1;

          // Increase the count for this column.
          // If col[c] doesn't exist yet, use 0 as default.
          col[c] = (col[c] ?? 0) + 1;
        }
      }
    }

    // -----------------------------
    // SECOND PASS: Find special positions
    // -----------------------------
    // Now that we know how many 1s are in each row and column,
    // we go through the matrix again.

    for (int r = 0; r < mat.length; ++r) {
      for (int c = 0; c < mat[r].length; ++c) {

        // Check three conditions:
        // 1. The current cell is 1
        // 2. The row contains exactly ONE 1
        // 3. The column contains exactly ONE 1
        if (mat[r][c] == 1 && row[r] == 1 && col[c] == 1) {

          // If all conditions are true,
          // then this is a special position.
          special += 1;
        }
      }
    }

    // Return the total number of special positions found.
    return special;
  }
}