class Solution {
    func maxProductPath(_ grid: [[Int]]) -> Int {
        
        // pos[i][j] = maximum POSITIVE product we can get to reach (i, j)
        var pos = Array(
            repeating: Array(repeating: Int.min, count: grid.first!.count),
            count: grid.count
        )

        // neg[i][j] = minimum NEGATIVE product we can get to reach (i, j)
        var neg = Array(
            repeating: Array(repeating: Int.max, count: grid.first!.count),
            count: grid.count
        )

        // Initialize starting cell (0,0)
        // If value is positive → store in pos
        // If negative → store in neg
        if grid.first!.first! >= 0 {
            pos[0][0] = grid.first!.first!
        } else {
            neg[0][0] = grid.first!.first!
        }

        // Queue for BFS-like propagation
        var q = [[0, 0]]

        // Process cells level by level
        while !q.isEmpty {
            var nq = [[Int]]() // next queue

            // Helper function to update "to" cell using "from" cell
            func visit(_ to: [Int], _ from: [Int]) {
                // Boundary check
                guard to[0] < grid.count, to[1] < grid[to[0]].count else { return }

                var p = Int.min // candidate positive product
                var n = Int.max // candidate negative product

                // Case 1: Extend from a positive product
                if pos[from[0]][from[1]] != Int.min {
                    let x = pos[from[0]][from[1]] * grid[to[0]][to[1]]
                    
                    if x >= 0 {
                        // stays positive
                        p = max(p, x)
                    } else {
                        // becomes negative
                        n = min(n, x)
                    }
                }

                // Case 2: Extend from a negative product
                if neg[from[0]][from[1]] != Int.max {
                    let x = neg[from[0]][from[1]] * grid[to[0]][to[1]]
                    
                    if x >= 0 {
                        // negative * negative = positive
                        p = max(p, x)
                    } else {
                        // negative * positive = negative
                        n = min(n, x)
                    }
                }

                // Update best positive value at destination
                if p > pos[to[0]][to[1]] {
                    pos[to[0]][to[1]] = p
                    nq.append(to) // push for further propagation
                }

                // Update best negative value at destination
                if n < neg[to[0]][to[1]] {
                    neg[to[0]][to[1]] = n
                    
                    // Avoid duplicate push if already added
                    if nq.last != to {
                        nq.append(to)
                    }
                }
            }

            // Explore right and down moves
            for p in q {
                visit([p[0] + 1, p[1]], p) // move down
                visit([p[0], p[1] + 1], p) // move right
            }

            // Move to next layer
            q = nq
        }

        // If no positive product path exists
        if pos.last!.last! == Int.min {
            // If grid contains 0, we can get product 0
            if grid.contains(where: { $0.contains(0) }) {
                return 0
            }
            return -1
        }

        // Return result modulo 1e9+7
        return pos.last!.last! % 1_000_000_007
    }
}