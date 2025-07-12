use std::cmp::{min, max};

impl Solution {
    /// Main function to compute the earliest and latest round in which 
    /// the two specified players can meet in a knockout tournament.
    pub fn earliest_and_latest(n: i32, first_player: i32, second_player: i32) -> Vec<i32> {
        // Set maximum number of players to 30 based on constraints
        const MAX_N: usize = 30;

        // 3D memoization arrays: 
        // f[n][first][second] = earliest round they meet
        // g[n][first][second] = latest round they meet
        let mut f = [[[0; MAX_N]; MAX_N]; MAX_N];
        let mut g = [[[0; MAX_N]; MAX_N]; MAX_N];

        // Convert to usize for indexing
        let mut first = first_player as usize;
        let mut second = second_player as usize;

        // Ensure first < second for symmetry and easier indexing
        if first > second {
            std::mem::swap(&mut first, &mut second);
        }

        // Recursively compute using dynamic programming
        let (earliest, latest) = Self::dp(n as usize, first, second, &mut f, &mut g);
        vec![earliest, latest]
    }

    /// Recursive DP function to compute earliest and latest round two players meet
    ///
    /// Parameters:
    /// - `n`: total number of players
    /// - `first`, `second`: current indices (1-based) of the two players in the round
    fn dp(n: usize, first: usize, second: usize, f: &mut [[[i32; 30]; 30]; 30], g: &mut [[[i32; 30]; 30]; 30]) -> (i32, i32) {
        // Return memoized results if already computed
        if f[n][first][second] != 0 {
            return (f[n][first][second], g[n][first][second]);
        }

        // Base case: players meet in the current round
        if first + second == n + 1 {
            return (1, 1);
        }

        // Use symmetry: (first, second) is same as (n+1-second, n+1-first)
        // This reduces the number of unique states to evaluate
        if first + second > n + 1 {
            let (x, y) = Self::dp(n, n + 1 - second, n + 1 - first, f, g);
            f[n][first][second] = x;
            g[n][first][second] = y;
            return (x, y);
        }

        // Recursive case: simulate all possible pairings in next round
        let mut earliest = i32::MAX;
        let mut latest = i32::MIN;

        // Half the number of players progress to the next round
        let n_half = (n + 1) / 2;

        if second <= n_half {
            // Case 1: both players are in the left half of the bracket
            // Simulate all possible pairings for first and second
            for i in 0..first {
                for j in 0..(second - first) {
                    // In next round, positions are adjusted based on eliminations
                    let (x, y) = Self::dp(n_half, i + 1, i + j + 2, f, g);
                    earliest = min(earliest, x);
                    latest = max(latest, y);
                }
            }
        } else {
            // Case 2: second player is in the right half of the bracket
            // Need to mirror second player and simulate matchups
            let s_prime = n + 1 - second;

            // mid: players in middle (after left side)
            let mid = (n - 2 * s_prime + 1) / 2;

            for i in 0..first {
                for j in 0..(s_prime - first) {
                    // Compute updated positions in next round
                    let (x, y) = Self::dp(n_half, i + 1, i + j + mid + 2, f, g);
                    earliest = min(earliest, x);
                    latest = max(latest, y);
                }
            }
        }

        // Store result with one additional round accounted
        f[n][first][second] = earliest + 1;
        g[n][first][second] = latest + 1;
        (f[n][first][second], g[n][first][second])
    }
}
