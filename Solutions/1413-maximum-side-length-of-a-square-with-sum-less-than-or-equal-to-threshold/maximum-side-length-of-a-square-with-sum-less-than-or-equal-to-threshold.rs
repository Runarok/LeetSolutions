impl Solution {
    pub fn max_side_length(mat: Vec<Vec<i32>>, threshold: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();

        // ------------------------------------------------------------
        // Step 1: Build a 2D prefix sum array
        //
        // prefix[i][j] represents the sum of elements in the rectangle
        // from (0,0) to (i-1, j-1) inclusive.
        //
        // We create it with size (m+1) x (n+1) to avoid bounds checking
        // when computing submatrix sums.
        // ------------------------------------------------------------
        let mut prefix = vec![vec![0; n + 1]; m + 1];

        for i in 0..m {
            for j in 0..n {
                prefix[i + 1][j + 1] =
                    prefix[i][j + 1] +    // sum above
                    prefix[i + 1][j] -    // sum left
                    prefix[i][j] +        // remove double-counted area
                    mat[i][j];            // add current cell
            }
        }

        // ------------------------------------------------------------
        // Helper closure to check if there exists a square of side `k`
        // whose sum is <= threshold.
        // ------------------------------------------------------------
        let exists_valid_square = |k: usize| -> bool {
            // Iterate over all possible top-left corners
            for i in 0..=m - k {
                for j in 0..=n - k {
                    // Compute sum of k x k square using prefix sums
                    let sum = prefix[i + k][j + k]
                        - prefix[i][j + k]
                        - prefix[i + k][j]
                        + prefix[i][j];

                    if sum <= threshold {
                        return true;
                    }
                }
            }
            false
        };

        // ------------------------------------------------------------
        // Step 2: Binary search on the answer (side length)
        // ------------------------------------------------------------
        let mut left = 0;
        let mut right = m.min(n); // maximum possible square size
        let mut answer = 0;

        while left <= right {
            let mid = (left + right) / 2;

            if exists_valid_square(mid) {
                // If a square of size `mid` exists,
                // try to find a bigger one
                answer = mid as i32;
                left = mid + 1;
            } else {
                // Otherwise, try smaller sizes
                right = mid - 1;
            }
        }

        answer
    }
}
