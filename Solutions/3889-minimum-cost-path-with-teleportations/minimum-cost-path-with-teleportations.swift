final class Solution {

    // A large value used as "infinity"
    private let INF = Int.max / 4

    // -------------------------------------------------------
    // Normal DP relaxation (right + down moves)
    // -------------------------------------------------------
    // dp[i][j] represents minimum cost to reach (i, j)
    // Normal moves can only come from:
    //   - top cell (i-1, j)
    //   - left cell (i, j-1)
    // Cost of entering (i, j) is grid[i][j]
    private func normalMoveUpdate(
        _ dp: inout [[Int]],
        _ grid: [[Int]],
        _ m: Int,
        _ n: Int
    ) {
        for i in 0..<m {
            for j in 0..<n {

                let v = grid[i][j]

                // Move from top
                if i > 0 {
                    dp[i][j] = min(dp[i][j], v + dp[i - 1][j])
                }

                // Move from left
                if j > 0 {
                    dp[i][j] = min(dp[i][j], v + dp[i][j - 1])
                }
            }
        }
    }

    // -------------------------------------------------------
    // Teleport DP relaxation (O(mn))
    // -------------------------------------------------------
    // teleMap is sorted by grid value:
    //   (value, row, col)
    //
    // Teleport rule:
    //   From any cell A, you can teleport to ANY cell B
    //   if grid[B] <= grid[A], cost = 0
    //
    // This means:
    //   All cells with value >= some minimum reachable cost
    //   can inherit the minimum dp among all smaller/equal values
    //
    // We implement this using:
    //   1) Group minimum for equal values
    //   2) Suffix minimum to propagate best reachable teleport cost
    private func teleportUpdate(
        _ dp: inout [[Int]],
        _ teleMap: [(Int, Int, Int)]
    ) {

        let ts = teleMap.count

        // Current value group being processed
        var currVal = -1

        // Minimum dp value inside the current value group
        var groupMin = INF

        // ---- First pass: handle same-value cells ----
        for idx in 0..<ts {
            let (v, r, c) = teleMap[idx]

            // New value group starts
            if v != currVal {
                currVal = v
                groupMin = dp[r][c]
            } else {
                // Same value: all can teleport among themselves
                groupMin = min(groupMin, dp[r][c])
                dp[r][c] = min(dp[r][c], groupMin)
            }
        }

        // ---- Second pass: suffix minimum ----
        // This allows higher values to inherit
        // the best dp from any smaller value
        let (_, rLast, cLast) = teleMap[ts - 1]
        var suffixMin = dp[rLast][cLast]

        if ts >= 2 {
            for idx in stride(from: ts - 2, through: 0, by: -1) {
                let (_, r, c) = teleMap[idx]
                let cur = dp[r][c]

                if cur < suffixMin {
                    suffixMin = cur
                } else {
                    dp[r][c] = suffixMin
                }
            }
        }
    }

    // -------------------------------------------------------
    // Main function
    // -------------------------------------------------------
    func minCost(_ grid: [[Int]], _ k: Int) -> Int {

        let m = grid.count
        let n = grid[0].count

        // Build teleport map:
        // (cell value, row, col)
        var teleMap = [(Int, Int, Int)]()
        teleMap.reserveCapacity(m * n)

        for i in 0..<m {
            for j in 0..<n {
                teleMap.append((grid[i][j], i, j))
            }
        }

        // Sort by value, then position (stable + deterministic)
        teleMap.sort {
            if $0.0 != $1.0 { return $0.0 < $1.0 }
            if $0.1 != $1.1 { return $0.1 < $1.1 }
            return $0.2 < $1.2
        }

        // dp[i][j] = minimum cost to reach (i, j)
        var dp = Array(
            repeating: Array(repeating: INF, count: n),
            count: m
        )

        // Starting point has cost 0
        dp[0][0] = 0

        // We simulate k teleports by running k+1 DP layers
        // Each layer:
        //   - normal move relaxation
        //   - teleport relaxation (except last layer)
        for step in stride(from: k, through: 0, by: -1) {

            // Apply all normal moves
            normalMoveUpdate(&dp, grid, m, n)

            // Apply teleport relaxation if teleports remain
            if step > 0 {
                teleportUpdate(&dp, teleMap)
            }
        }

        // Final answer
        return dp[m - 1][n - 1]
    }
}
