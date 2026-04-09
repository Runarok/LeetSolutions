impl Solution {
    pub fn xor_after_queries(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> i32 {
        
        // Modulo value (prime)
        const MOD: i64 = 1_000_000_007;

        // Convert nums to i64 for safe multiplication
        let mut nums: Vec<i64> = nums.into_iter().map(|x| x as i64).collect();

        let n = nums.len();

        // Threshold (sqrt decomposition)
        // k < t → small step
        // k >= t → large step
        let t = (n as f64).sqrt() as usize;

        // groups[k] will store all queries with step size = k
        // Each entry: (l, r, v)
        let mut groups: Vec<Vec<(usize, usize, i64)>> = vec![vec![]; t];

        // Process queries
        for q in queries {
            let l = q[0] as usize;
            let r = q[1] as usize;
            let k = q[2] as usize;
            let v = q[3] as i64;

            if k < t {
                // Small step → store for batch processing later
                groups[k].push((l, r, v));
            } else {
                // Large step → brute force (few iterations only)
                let mut i = l;
                while i <= r {
                    nums[i] = nums[i] * v % MOD;
                    i += k;
                }
            }
        }

        // Difference array (used per k)
        // Size n + t ensures safe indexing when stepping by k
        let mut dif = vec![1; n + t];

        // Process all small k
        for k in 1..t {

            // Skip if no queries for this k
            if groups[k].is_empty() {
                continue;
            }

            // Reset difference array to multiplicative identity
            dif.fill(1);

            // Apply all queries of this k
            for &(l, r, v) in &groups[k] {

                // Start multiplying from index l
                dif[l] = dif[l] * v % MOD;

                // Find stopping point:
                // last valid index in progression + k
                let r_idx = ((r - l) / k + 1) * k + l;

                // Multiply inverse at stopping point
                // This cancels effect beyond r
                dif[r_idx] = dif[r_idx] * Self::pow_mod(v, MOD - 2, MOD) % MOD;
            }

            // Build prefix product with step k
            // This propagates multipliers across indices
            for i in k..n {
                dif[i] = dif[i] * dif[i - k] % MOD;
            }

            // Apply computed multipliers to nums
            for i in 0..n {
                nums[i] = nums[i] * dif[i] % MOD;
            }
        }

        // Compute XOR of final array
        nums.into_iter().fold(0, |acc, x| acc ^ x as i32)
    }

    // Fast exponentiation (binary exponentiation)
    // Used to compute modular inverse: v^(MOD-2) % MOD
    fn pow_mod(mut x: i64, mut y: i64, m: i64) -> i64 {
        let mut res = 1;

        while y > 0 {
            // If current bit is 1 → multiply
            if y & 1 == 1 {
                res = res * x % m;
            }

            // Square base
            x = x * x % m;

            // Move to next bit
            y >>= 1;
        }

        res
    }
}