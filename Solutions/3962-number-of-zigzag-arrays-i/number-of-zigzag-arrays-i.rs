impl Solution {
    pub fn zig_zag_arrays(n: i32, l: i32, r: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;

        let n = n as usize;
        let m = (r - l + 1) as usize;

        // Not needed by constraints, but keeps the implementation complete.
        if n == 1 {
            return (m as i64 % MOD) as i32;
        }

        // up[v]:
        // number of arrays of current length ending at value v
        // whose last step was increasing (... < v)
        //
        // down[v]:
        // number of arrays of current length ending at value v
        // whose last step was decreasing (... > v)
        //
        // Values are indexed 0..m-1 instead of [l, r].
        let mut up = vec![0i64; m];
        let mut down = vec![0i64; m];

        // Length = 2 initialization.
        //
        // For a fixed ending value y:
        // - increasing pairs ending at y: choose any x < y
        // - decreasing pairs ending at y: choose any x > y
        for y in 0..m {
            up[y] = y as i64;             // count of x < y
            down[y] = (m - 1 - y) as i64; // count of x > y
        }

        // Build lengths 3..n.
        for _len in 3..=n {
            let mut pref_up = vec![0i64; m + 1];
            let mut pref_down = vec![0i64; m + 1];

            for i in 0..m {
                pref_up[i + 1] = (pref_up[i] + up[i]) % MOD;
                pref_down[i + 1] = (pref_down[i] + down[i]) % MOD;
            }

            let total_up = pref_up[m];

            let mut next_up = vec![0i64; m];
            let mut next_down = vec![0i64; m];

            for y in 0..m {
                // To end with an increasing step:
                // previous value x must satisfy x < y.
                //
                // Also we cannot extend a previous "up" state,
                // otherwise we'd create three consecutive values
                // that are strictly increasing.
                next_up[y] = pref_down[y];

                // To end with a decreasing step:
                // previous value x must satisfy x > y.
                //
                // Likewise, we may only extend an "up" state.
                next_down[y] = (total_up - pref_up[y + 1] + MOD) % MOD;
            }

            up = next_up;
            down = next_down;
        }

        let mut ans = 0i64;
        for v in 0..m {
            ans = (ans + up[v] + down[v]) % MOD;
        }

        ans as i32
    }
}