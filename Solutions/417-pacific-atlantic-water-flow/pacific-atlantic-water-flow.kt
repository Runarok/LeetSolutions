class Solution {
    fun pacificAtlantic(heights: Array<IntArray>): List<List<Int>> {
        val m = heights.size
        val n = heights[0].size

        // Create two boolean matrices to track reachable cells
        val pacific = Array(m) { BooleanArray(n) }
        val atlantic = Array(m) { BooleanArray(n) }

        // DFS function
        fun dfs(r: Int, c: Int, visited: Array<BooleanArray>, prevHeight: Int) {
            // Boundary checks
            if (r < 0 || c < 0 || r >= m || c >= n) return
            // Already visited or current height is less than previous (invalid flow)
            if (visited[r][c] || heights[r][c] < prevHeight) return

            // Mark cell as visited
            visited[r][c] = true

            // Visit all 4 directions
            val directions = listOf(Pair(1,0), Pair(-1,0), Pair(0,1), Pair(0,-1))
            for ((dr, dc) in directions) {
                dfs(r + dr, c + dc, visited, heights[r][c])
            }
        }

        // Start DFS from Pacific Ocean borders
        for (i in 0 until m) {
            dfs(i, 0, pacific, heights[i][0]) // Left column
            dfs(i, n - 1, atlantic, heights[i][n - 1]) // Right column
        }

        for (j in 0 until n) {
            dfs(0, j, pacific, heights[0][j]) // Top row
            dfs(m - 1, j, atlantic, heights[m - 1][j]) // Bottom row
        }

        // Collect cells that can reach both oceans
        val result = mutableListOf<List<Int>>()
        for (r in 0 until m) {
            for (c in 0 until n) {
                if (pacific[r][c] && atlantic[r][c]) {
                    result.add(listOf(r, c))
                }
            }
        }

        return result
    }
}
