impl Solution {
    pub fn max_building(n: i32, restrictions: Vec<Vec<i32>>) -> i32 {
        // Copy restrictions so we can modify them
        let mut r = restrictions;

        // Building 1 must have height 0
        r.push(vec![1, 0]);

        // Building n can never exceed n-1
        // (starting from building 1 at height 0,
        // increasing by at most 1 each step)
        r.push(vec![n, n - 1]);

        // Sort by building index
        r.sort_by_key(|x| x[0]);

        let m = r.len();

        // ----------------------------------------------------
        // Forward pass
        //
        // If building i-1 has max height h,
        // then building i cannot exceed:
        //
        // h + distance
        //
        // because height can increase by at most 1 per step.
        // ----------------------------------------------------
        for i in 1..m {
            let dist = r[i][0] - r[i - 1][0];

            r[i][1] = r[i][1].min(r[i - 1][1] + dist);
        }

        // ----------------------------------------------------
        // Backward pass
        //
        // Same logic in the opposite direction.
        //
        // If right restriction is tighter,
        // it may force the left restriction lower.
        // ----------------------------------------------------
        for i in (0..m - 1).rev() {
            let dist = r[i + 1][0] - r[i][0];

            r[i][1] = r[i][1].min(r[i + 1][1] + dist);
        }

        let mut ans = 0;

        // ----------------------------------------------------
        // For every neighboring restriction pair:
        //
        // (id1, h1)
        // (id2, h2)
        //
        // Maximum achievable peak between them:
        //
        // (h1 + h2 + distance) / 2
        // ----------------------------------------------------
        for i in 1..m {
            let id1 = r[i - 1][0];
            let h1 = r[i - 1][1];

            let id2 = r[i][0];
            let h2 = r[i][1];

            let dist = id2 - id1;

            let peak = (h1 + h2 + dist) / 2;

            ans = ans.max(peak);
        }

        ans
    }
}