function totalNQueens(n: number): number {
    // Total number of valid solutions
    let count = 0;

    // --------------------------------------------------------
    // Sets to track which columns and diagonals are occupied
    // --------------------------------------------------------
    const cols = new Set<number>();       // Columns
    const diag1 = new Set<number>();      // r - c, top-left to bottom-right
    const diag2 = new Set<number>();      // r + c, top-right to bottom-left

    // --------------------------------------------------------
    // Backtracking function: try placing queens row by row
    // --------------------------------------------------------
    const backtrack = (row: number) => {
        // Base case: all rows filled → valid solution found
        if (row === n) {
            count++;
            return;
        }

        // Try placing a queen in every column of current row
        for (let col = 0; col < n; col++) {
            // Check if column or diagonals are already occupied
            if (cols.has(col) || diag1.has(row - col) || diag2.has(row + col)) {
                continue; // can't place queen here
            }

            // Place the queen
            cols.add(col);
            diag1.add(row - col);
            diag2.add(row + col);

            // Move to the next row
            backtrack(row + 1);

            // Backtrack: remove queen to try next column
            cols.delete(col);
            diag1.delete(row - col);
            diag2.delete(row + col);
        }
    };

    // Start backtracking from row 0
    backtrack(0);

    return count;
}
