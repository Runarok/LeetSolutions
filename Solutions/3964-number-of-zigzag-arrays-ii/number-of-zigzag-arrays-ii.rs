impl Solution {
    pub fn zig_zag_arrays(n: i32, l: i32, r: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;

        let m = (r - l + 1) as usize;

        // A[i][j] = min(i, j) - 1  (1-indexed formula)
        // Using 0-indexing:
        // A[i][j] = min(i, j)
        let mut a = vec![vec![0i64; m]; m];
        for i in 0..m {
            for j in 0..m {
                a[i][j] = (i.min(j) as i64) % MOD;
            }
        }

        // Base vector:
        //
        // U_k[v] = #arrays of length k ending at value v
        //          whose last comparison is UP.
        //
        // For length 2:
        // U2[v] = count of smaller previous values = v - 1
        //
        // For length 3:
        // U3[v] = sum_{x < v} D2[x]
        //       = sum_{x=1}^{v-1} (m - x)
        let mut base = vec![0i64; m];
        let steps: i64;

        if n % 2 == 0 {
            // length 2 base
            for v in 0..m {
                base[v] = v as i64;
            }
            steps = ((n - 2) / 2) as i64;
        } else {
            // length 3 base
            for v in 0..m {
                let t = v as i64; // v-1 in 1-indexing
                base[v] = (t * (m as i64) - t * (t + 1) / 2) % MOD;
            }
            steps = ((n - 3) / 2) as i64;
        }

        // Fast exponentiation:
        // result_vec = A^steps * base
        let final_u = Self::mat_pow_apply(a, steps, base, MOD);

        // By symmetry:
        // total = sum(U_n) + sum(D_n)
        //       = 2 * sum(U_n)
        let mut ans = 0i64;
        for x in final_u {
            ans += x;
            ans %= MOD;
        }

        ans = ans * 2 % MOD;
        ans as i32
    }

    // Computes (mat^exp) * vec
    fn mat_pow_apply(
        mut mat: Vec<Vec<i64>>,
        mut exp: i64,
        mut vec: Vec<i64>,
        modulo: i64,
    ) -> Vec<i64> {
        let n = mat.len();

        while exp > 0 {
            if exp & 1 == 1 {
                vec = Self::mat_vec_mul(&mat, &vec, modulo);
            }

            mat = Self::mat_mul(&mat, &mat, modulo);
            exp >>= 1;
        }

        vec
    }

    fn mat_vec_mul(mat: &Vec<Vec<i64>>, vec: &Vec<i64>, modulo: i64) -> Vec<i64> {
        let n = mat.len();
        let mut res = vec![0i64; n];

        for i in 0..n {
            let mut cur = 0i64;
            for j in 0..n {
                cur = (cur + mat[i][j] * vec[j]) % modulo;
            }
            res[i] = cur;
        }

        res
    }

    fn mat_mul(a: &Vec<Vec<i64>>, b: &Vec<Vec<i64>>, modulo: i64) -> Vec<Vec<i64>> {
        let n = a.len();
        let mut res = vec![vec![0i64; n]; n];

        for i in 0..n {
            for k in 0..n {
                let aik = a[i][k];
                if aik == 0 {
                    continue;
                }

                for j in 0..n {
                    res[i][j] = (res[i][j] + aik * b[k][j]) % modulo;
                }
            }
        }

        res
    }
}