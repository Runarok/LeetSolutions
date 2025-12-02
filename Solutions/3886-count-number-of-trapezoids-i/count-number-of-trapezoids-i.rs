impl Solution {
    pub fn count_trapezoids(points: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashMap;
        const MOD: i64 = 1_000_000_007;

        // Count occurrences of each y-coordinate
        let mut count = HashMap::<i32, i64>::new();
        for p in points {
            *count.entry(p[1]).or_insert(0) += 1;
        }

        // For each y-level, compute number of horizontal segments C(n,2)
        let mut segs = Vec::<i64>::new();
        for &c in count.values() {
            if c >= 2 {
                segs.push((c * (c - 1) / 2) % MOD);
            }
        }

        // If fewer than 2 horizontal segments total, no trapezoid can form
        if segs.len() < 2 {
            return 0;
        }

        // Compute sum of segs and sum of squares
        let mut sum = 0i64;
        let mut sum_sq = 0i64;

        for s in &segs {
            sum = (sum + s) % MOD;
            sum_sq = (sum_sq + (s * s) % MOD) % MOD;
        }

        // Using formula: (sum^2 - sum of squares) / 2
        let mut ans = (sum * sum % MOD - sum_sq + MOD) % MOD;

        // multiply by modular inverse of 2 (which is (MOD+1)/2 for prime MOD)
        let inv2 = (MOD + 1) / 2;
        ans = ans * inv2 % MOD;

        ans as i32
    }
}
