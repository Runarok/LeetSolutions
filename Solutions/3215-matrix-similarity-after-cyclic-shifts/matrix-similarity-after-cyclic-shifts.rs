impl Solution {
    pub fn are_similar(mat: Vec<Vec<i32>>, k: i32) -> bool {
        // Convert k to usize since we'll use it for indexing
        let k = k as usize;

        // n = number of columns
        let n = mat[0].len();

        // m = number of rows
        let m = mat.len();

        // If k is a multiple of n, shifting does nothing → matrix stays same
        // So it's automatically similar
        k % n == 0 || {
            // Create a new matrix of same size filled with 0s
            // This will store the shifted version
            let mut shifted_mat = vec![vec![0; n]; m];

            // Iterate over each row with its index
            shifted_mat.iter_mut().enumerate().for_each(|(i, row)| 
                // For each row:
                // - row.iter_mut() gives mutable references to destination cells
                // - mat[i].iter().cycle().skip(k % n):
                //     * iter() → iterate original row
                //     * cycle() → repeat infinitely
                //     * skip(k % n) → simulate left rotation by k
                row.iter_mut()
                    .zip(mat[i].iter().cycle().skip(k % n))
                    .for_each(|(dst, src)| 
                        // Copy shifted values into new matrix
                        *dst = *src
                    )
            );

            // Compare original matrix with shifted matrix
            // If equal → return true, else false
            mat == shifted_mat
        }
    }
}