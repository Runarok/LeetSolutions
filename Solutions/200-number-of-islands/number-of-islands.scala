object Solution {
    def numIslands(grid: Array[Array[Char]]): Int = {

        // Edge case: empty grid
        if (grid.isEmpty) return 0

        val m = grid.length       // number of rows
        val n = grid(0).length    // number of columns

        var count = 0             // number of islands

        // DFS function to "sink" the island
        def dfs(r: Int, c: Int): Unit = {

            // Boundary check + water check
            // Stop if:
            // - out of bounds
            // - or current cell is water ('0')
            if (r < 0 || c < 0 || r >= m || c >= n || grid(r)(c) == '0') {
                return
            }

            // Mark current land as visited (sink it)
            grid(r)(c) = '0'

            // Explore all 4 directions (up, down, left, right)
            dfs(r + 1, c) // down
            dfs(r - 1, c) // up
            dfs(r, c + 1) // right
            dfs(r, c - 1) // left
        }

        // Traverse entire grid
        for (r <- 0 until m) {
            for (c <- 0 until n) {

                // Found an unvisited land cell → new island
                if (grid(r)(c) == '1') {
                    count += 1

                    // Sink the whole island
                    dfs(r, c)
                }
            }
        }

        count
    }
}