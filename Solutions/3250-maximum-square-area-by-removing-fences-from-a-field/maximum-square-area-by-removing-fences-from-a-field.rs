use std::collections::HashSet;

impl Solution {
    pub fn maximize_square_area(
        m: i32,
        n: i32,
        mut h_fences: Vec<i32>,
        mut v_fences: Vec<i32>,
    ) -> i32 {

        const MOD: i64 = 1_000_000_007;

        // ------------------------------------------------------------
        // 1. Add the boundary fences (they cannot be removed)
        // ------------------------------------------------------------
        h_fences.push(1);
        h_fences.push(m);

        v_fences.push(1);
        v_fences.push(n);

        // ------------------------------------------------------------
        // 2. Sort fences so we can compute distances cleanly
        // ------------------------------------------------------------
        h_fences.sort();
        v_fences.sort();

        // ------------------------------------------------------------
        // 3. Compute all possible horizontal distances
        //    Store them in a HashSet for fast lookup
        // ------------------------------------------------------------
        let mut horizontal_distances = HashSet::new();

        for i in 0..h_fences.len() {
            for j in i + 1..h_fences.len() {
                let dist = (h_fences[j] - h_fences[i]) as i64;
                horizontal_distances.insert(dist);
            }
        }

        // ------------------------------------------------------------
        // 4. Compute vertical distances and find the largest
        //    one that also exists in horizontal distances
        // ------------------------------------------------------------
        let mut max_side: i64 = -1;

        for i in 0..v_fences.len() {
            for j in i + 1..v_fences.len() {
                let dist = (v_fences[j] - v_fences[i]) as i64;

                // Check if we can form a square with this side length
                if horizontal_distances.contains(&dist) {
                    max_side = max_side.max(dist);
                }
            }
        }

        // ------------------------------------------------------------
        // 5. If no square is possible, return -1
        // ------------------------------------------------------------
        if max_side == -1 {
            return -1;
        }

        // ------------------------------------------------------------
        // 6. Return area = side^2 % MOD
        // ------------------------------------------------------------
        ((max_side * max_side) % MOD) as i32
    }
}
