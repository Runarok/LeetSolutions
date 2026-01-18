impl Solution {
    pub fn largest_magic_square(grid: Vec<Vec<i32>>) -> i32 {
        // Number of rows (m) and columns (n)
        let m = grid.len();
        let n = grid[0].len();

        // ------------------------------------------------------------
        // PREFIX SUMS
        // ------------------------------------------------------------

        // row_sum[r][c] = sum of row r from column 0 to c-1
        let mut row_sum = vec![vec![0; n + 1]; m];

        // col_sum[r][c] = sum of column c from row 0 to r-1
        let mut col_sum = vec![vec![0; n]; m + 1];

        // diag1[r][c] = main diagonal prefix sum (top-left to bottom-right)
        // Used for \ diagonal
        let mut diag1 = vec![vec![0; n + 1]; m + 1];

        // diag2[r][c] = anti-diagonal prefix sum (top-right to bottom-left)
        // Used for / diagonal
        let mut diag2 = vec![vec![0; n + 1]; m + 1];

        // ------------------------------------------------------------
        // BUILD PREFIX SUM TABLES
        // ------------------------------------------------------------
        for r in 0..m {
            for c in 0..n {
                // Row prefix sum
                row_sum[r][c + 1] = row_sum[r][c] + grid[r][c];

                // Column prefix sum
                col_sum[r + 1][c] = col_sum[r][c] + grid[r][c];

                // Main diagonal prefix sum (\)
                diag1[r + 1][c + 1] = diag1[r][c] + grid[r][c];

                // Anti-diagonal prefix sum (/)
                diag2[r + 1][c] = diag2[r][c + 1] + grid[r][c];
            }
        }

        // ------------------------------------------------------------
        // TRY ALL SQUARE SIZES (LARGEST → SMALLEST)
        // ------------------------------------------------------------
        let max_k = std::cmp::min(m, n);

        // Start from the largest possible square
        for k in (2..=max_k).rev() {
            // Try every possible top-left corner
            for r in 0..=m - k {
                for c in 0..=n - k {
                    // ------------------------------------------------
                    // TARGET SUM (FIRST ROW)
                    // ------------------------------------------------
                    let target = row_sum[r][c + k] - row_sum[r][c];

                    let mut valid = true;

                    // ------------------------------------------------
                    // CHECK ALL ROW SUMS
                    // ------------------------------------------------
                    for i in 0..k {
                        let sum = row_sum[r + i][c + k] - row_sum[r + i][c];
                        if sum != target {
                            valid = false;
                            break;
                        }
                    }

                    if !valid {
                        continue;
                    }

                    // ------------------------------------------------
                    // CHECK ALL COLUMN SUMS
                    // ------------------------------------------------
                    for j in 0..k {
                        let sum = col_sum[r + k][c + j] - col_sum[r][c + j];
                        if sum != target {
                            valid = false;
                            break;
                        }
                    }

                    if !valid {
                        continue;
                    }

                    // ------------------------------------------------
                    // CHECK MAIN DIAGONAL (\)
                    // ------------------------------------------------
                    let diag_main =
                        diag1[r + k][c + k] - diag1[r][c];
                    if diag_main != target {
                        continue;
                    }

                    // ------------------------------------------------
                    // CHECK ANTI-DIAGONAL (/)
                    // ------------------------------------------------
                    let diag_anti =
                        diag2[r + k][c] - diag2[r][c + k];
                    if diag_anti != target {
                        continue;
                    }

                    // ------------------------------------------------
                    // FOUND A VALID MAGIC SQUARE
                    // ------------------------------------------------
                    return k as i32;
                }
            }
        }

        // ------------------------------------------------------------
        // IF NO LARGER SQUARE FOUND, RETURN 1
        // ------------------------------------------------------------
        1
    }
}
