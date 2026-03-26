use std::collections::HashMap;

impl Solution {
    pub fn can_partition_grid(grid: Vec<Vec<i32>>) -> bool {
        // Number of rows and columns
        let n = grid.len();
        let m = grid[0].len();

        // Prefix sum arrays:
        // pref_row[i] = sum of all elements from row 0 to row i
        let mut pref_row = vec![0i64; n];

        // pref_col[j] = sum of all elements from column 0 to column j
        let mut pref_col = vec![0i64; m];

        // Map value -> list of coordinates where it appears
        // Used to quickly find if we can remove a cell with specific value
        let mut mp: HashMap<i32, Vec<(usize, usize)>> = HashMap::new();

        // Build row prefix sums and populate hashmap
        for i in 0..n {
            let mut row_sum = 0i64;
            for j in 0..m {
                let val = grid[i][j];

                // Add current value to row sum
                row_sum += val as i64;

                // Store position of this value
                mp.entry(val).or_insert(Vec::new()).push((i, j));
            }

            // Prefix accumulation
            pref_row[i] = row_sum + if i > 0 { pref_row[i - 1] } else { 0 };
        }

        // Build column prefix sums
        for j in 0..m {
            let mut col_sum = 0i64;
            for i in 0..n {
                col_sum += grid[i][j] as i64;
            }

            // Prefix accumulation
            pref_col[j] = col_sum + if j > 0 { pref_col[j - 1] } else { 0 };
        }

        // Total sum of entire grid
        let total = pref_row[n - 1];

        // Helper function:
        // Checks whether removing cell (i, j) from sub-rectangle (r1,c1) to (r2,c2) is valid
        fn can_remove(r1: usize, c1: usize, r2: usize, c2: usize, i: usize, j: usize) -> bool {
            let rows = r2 - r1 + 1;
            let cols = c2 - c1 + 1;

            // If only one cell exists, cannot remove anything
            if rows * cols <= 1 { return false; }

            // If single row → can only remove from ends
            if rows == 1 { return j == c1 || j == c2; }

            // If single column → can only remove from ends
            if cols == 1 { return i == r1 || i == r2; }

            // Otherwise, any cell can be removed
            true
        }

        // Try horizontal splits
        for i in 0..n - 1 {
            // Sum of top part
            let top = pref_row[i];

            // Sum of bottom part
            let bottom = total - top;

            // If already equal, partition is valid
            if top == bottom { return true; }

            // Difference we need to fix by removing one element
            let diff = (top - bottom).abs();

            // Check if diff fits in i32
            if diff <= i32::MAX as i64 {
                // Check if such a value exists in grid
                if let Some(coords) = mp.get(&(diff as i32)) {
                    for &(x, y) in coords {
                        if top > bottom {
                            // Remove from top part
                            if x <= i && can_remove(0, 0, i, m - 1, x, y) {
                                return true;
                            }
                        } else {
                            // Remove from bottom part
                            if x > i && can_remove(i + 1, 0, n - 1, m - 1, x, y) {
                                return true;
                            }
                        }
                    }
                }
            }
        }

        // Try vertical splits
        for j in 0..m - 1 {
            // Sum of left part
            let left = pref_col[j];

            // Sum of right part
            let right = total - left;

            // If already equal
            if left == right { return true; }

            // Difference to fix
            let diff = (left - right).abs();

            if diff <= i32::MAX as i64 {
                if let Some(coords) = mp.get(&(diff as i32)) {
                    for &(x, y) in coords {
                        if left > right {
                            // Remove from left part
                            if y <= j && can_remove(0, 0, n - 1, j, x, y) {
                                return true;
                            }
                        } else {
                            // Remove from right part
                            if y > j && can_remove(0, j + 1, n - 1, m - 1, x, y) {
                                return true;
                            }
                        }
                    }
                }
            }
        }

        // No valid partition found
        false
    }
}