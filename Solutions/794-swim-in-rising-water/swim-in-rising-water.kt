class Solution {
    fun swimInWater(grid: Array<IntArray>): Int {
        val n = grid.size // Grid is n x n

        // 4 possible directions: up, down, left, right
        val directions = arrayOf(
            intArrayOf(-1, 0),
            intArrayOf(1, 0),
            intArrayOf(0, -1),
            intArrayOf(0, 1)
        )

        // Use Java's PriorityQueue directly without importing it
        val pq = java.util.PriorityQueue<Triple<Int, Int, Int>>(compareBy { it.third })

        // Track visited cells to avoid cycles
        val visited = Array(n) { BooleanArray(n) }

        // Start from the top-left corner (0, 0)
        // Initial time is the elevation at (0, 0)
        pq.add(Triple(0, 0, grid[0][0]))
        visited[0][0] = true

        // While there are cells to process
        while (pq.isNotEmpty()) {
            // Get the cell with the lowest max elevation so far
            val (row, col, maxElevation) = pq.poll()

            // If we've reached the bottom-right, return the max elevation on this path
            if (row == n - 1 && col == n - 1) {
                return maxElevation
            }

            // Explore all 4 directions
            for (dir in directions) {
                val newRow = row + dir[0]
                val newCol = col + dir[1]

                // Make sure the new cell is within the grid and not yet visited
                if (newRow in 0 until n && newCol in 0 until n && !visited[newRow][newCol]) {
                    visited[newRow][newCol] = true

                    // Elevation we must wait for is the max of current path and new cell
                    val newElevation = maxOf(maxElevation, grid[newRow][newCol])

                    // Add new cell to the queue
                    pq.add(Triple(newRow, newCol, newElevation))
                }
            }
        }

        // Should never reach here if grid is valid
        return -1
    }
}
