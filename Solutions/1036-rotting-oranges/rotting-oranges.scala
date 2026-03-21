import scala.collection.mutable.Queue

object Solution {
    def orangesRotting(grid: Array[Array[Int]]): Int = {

        val m = grid.length
        val n = grid(0).length

        // Queue for BFS: stores (row, col)
        val queue = Queue[(Int, Int)]()

        var fresh = 0 // count of fresh oranges

        // Step 1: Initialize queue and count fresh oranges
        for (r <- 0 until m) {
            for (c <- 0 until n) {
                if (grid(r)(c) == 2) {
                    // Rotten orange → starting point
                    queue.enqueue((r, c))
                } else if (grid(r)(c) == 1) {
                    fresh += 1
                }
            }
        }

        // Edge case: no fresh oranges at all
        if (fresh == 0) return 0

        var minutes = 0

        // Directions: up, down, left, right
        val directions = Array((1,0), (-1,0), (0,1), (0,-1))

        // Step 2: BFS
        while (queue.nonEmpty) {

            val size = queue.size
            var rottedThisMinute = false

            // Process all oranges at current "minute"
            for (_ <- 0 until size) {
                val (r, c) = queue.dequeue()

                // Check all 4 directions
                for ((dr, dc) <- directions) {
                    val nr = r + dr
                    val nc = c + dc

                    // If valid cell and fresh orange found
                    if (nr >= 0 && nc >= 0 && nr < m && nc < n && grid(nr)(nc) == 1) {

                        // Rot it
                        grid(nr)(nc) = 2

                        // Add to queue for next round
                        queue.enqueue((nr, nc))

                        // Decrease fresh count
                        fresh -= 1

                        rottedThisMinute = true
                    }
                }
            }

            // Only increment time if something rotted
            if (rottedThisMinute) {
                minutes += 1
            }
        }

        // If fresh oranges still remain → impossible
        if (fresh > 0) -1 else minutes
    }
}