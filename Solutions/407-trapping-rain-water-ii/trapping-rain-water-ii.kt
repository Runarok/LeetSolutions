class Solution {
    fun trapRainWater(heightMap: Array<IntArray>): Int {
        val m = heightMap.size            // Total rows
        val n = heightMap[0].size         // Total columns

        // If the grid is too small (no inner cells), no water can be trapped
        if (m <= 2 || n <= 2) return 0

        // Use a PriorityQueue (min-heap) to always process the lowest boundary first
        val pq = java.util.PriorityQueue<Triple<Int, Int, Int>>(compareBy { it.first })
        // Each element in the heap is a Triple<height, row, column>

        // Visited matrix to keep track of cells we've already processed
        val visited = Array(m) { BooleanArray(n) }

        // Step 1: Add all boundary cells to the min-heap (they cannot hold water themselves)
        for (i in 0 until m) {
            // Left and right border
            pq.add(Triple(heightMap[i][0], i, 0))
            pq.add(Triple(heightMap[i][n - 1], i, n - 1))
            visited[i][0] = true
            visited[i][n - 1] = true
        }

        for (j in 1 until n - 1) {
            // Top and bottom border (excluding corners already added)
            pq.add(Triple(heightMap[0][j], 0, j))
            pq.add(Triple(heightMap[m - 1][j], m - 1, j))
            visited[0][j] = true
            visited[m - 1][j] = true
        }

        // Directions to move in the grid (right, down, left, up)
        val dirs = arrayOf(
            intArrayOf(0, 1),   // Right
            intArrayOf(1, 0),   // Down
            intArrayOf(0, -1),  // Left
            intArrayOf(-1, 0)   // Up
        )

        var waterTrapped = 0              // Final result: total water trapped
        var maxBoundaryHeight = 0         // Tracks the highest boundary we've seen so far

        // Step 2: Process the grid using BFS from the boundary inward
        while (pq.isNotEmpty()) {
            val (height, x, y) = pq.poll()   // Get the cell with the lowest height

            // Update the highest boundary seen so far
            maxBoundaryHeight = maxOf(maxBoundaryHeight, height)

            // Check all 4 directions from the current cell
            for (dir in dirs) {
                val nx = x + dir[0]
                val ny = y + dir[1]

                // Skip if neighbor is out of bounds or already visited
                if (nx !in 0 until m || ny !in 0 until n || visited[nx][ny]) continue

                visited[nx][ny] = true       // Mark this cell as visited

                val neighborHeight = heightMap[nx][ny]

                // If neighbor is lower than the current boundary, it can trap water
                if (neighborHeight < maxBoundaryHeight) {
                    val trapped = maxBoundaryHeight - neighborHeight
                    waterTrapped += trapped  // Add trapped water at this cell
                }

                // Push the neighbor into the heap regardless of water trapping
                // It becomes part of the boundary now
                pq.add(Triple(neighborHeight, nx, ny))
            }
        }

        // Return the total volume of trapped water
        return waterTrapped
    }
}
