function solveNQueens(n: number): string[][] {
    const results: string[][] = [];

    // --------------------------------------------------------
    // Keep track of which columns are occupied by queens
    // --------------------------------------------------------
    const cols = new Set<number>();

    // --------------------------------------------------------
    // Keep track of diagonals occupied
    // "diag1" is r - c, "diag2" is r + c
    // --------------------------------------------------------
    const diag1 = new Set<number>(); // top-left to bottom-right
    const diag2 = new Set<number>(); // top-right to bottom-left

    // --------------------------------------------------------
    // currentBoard[row] = column index where the queen is placed
    // --------------------------------------------------------
    const currentBoard: number[] = [];

    // --------------------------------------------------------
    // Helper function: generate board strings from positions
    // --------------------------------------------------------
    const generateBoard = (positions: number[]): string[] => {
        const board: string[] = [];
        for (let r = 0; r < n; r++) {
            const row = Array(n).fill('.');
            row[positions[r]] = 'Q'; // place queen
            board.push(row.join(''));
        }
        return board;
    };

    // --------------------------------------------------------
    // Backtracking function: try placing queens row by row
    // --------------------------------------------------------
    const backtrack = (row: number) => {
        // Base case: all rows filled
        if (row === n) {
            results.push(generateBoard(currentBoard));
            return;
        }

        // Try placing a queen in every column
        for (let col = 0; col < n; col++) {
            // Check if column or diagonals are already occupied
            if (cols.has(col) || diag1.has(row - col) || diag2.has(row + col)) {
                continue; // can't place queen here
            }

            // Place the queen
            currentBoard.push(col);
            cols.add(col);
            diag1.add(row - col);
            diag2.add(row + col);

            // Move to next row
            backtrack(row + 1);

            // Backtrack: remove queen and try next column
            currentBoard.pop();
            cols.delete(col);
            diag1.delete(row - col);
            diag2.delete(row + col);
        }
    };

    // Start from row 0
    backtrack(0);

    return results;
}
