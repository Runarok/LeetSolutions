class Solution {
    fun maxPoints(grid: Array<IntArray>, queries: IntArray): IntArray {
        val rows = grid.size
        val cols = grid[0].size
        val directions = arrayOf(intArrayOf(0, 1), intArrayOf(1, 0), intArrayOf(0, -1), intArrayOf(-1, 0))

        // Sort queries with their original indices
        val sortedQueries = queries.mapIndexed { index, value -> Pair(value, index) }
            .sortedBy { it.first }

        val result = IntArray(queries.size)

        val minHeap = PriorityQueue(compareBy<Pair<Int, Pair<Int, Int>>> { it.first })
        val visited = Array(rows) { BooleanArray(cols) }

        minHeap.add(Pair(grid[0][0], Pair(0, 0)))
        visited[0][0] = true
        var points = 0

        for ((queryVal, queryIdx) in sortedQueries) {
            while (minHeap.isNotEmpty() && minHeap.peek().first < queryVal) {
                val (_, pos) = minHeap.poll()
                val (r, c) = pos
                points++

                for (d in directions) {
                    val nr = r + d[0]
                    val nc = c + d[1]
                    if (nr in 0 until rows && nc in 0 until cols && !visited[nr][nc]) {
                        minHeap.add(Pair(grid[nr][nc], Pair(nr, nc)))
                        visited[nr][nc] = true
                    }
                }
            }

            result[queryIdx] = points
        }
        return result
    }
}