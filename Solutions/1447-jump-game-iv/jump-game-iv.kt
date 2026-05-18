class Solution {
    fun minJumps(arr: IntArray): Int {
        // If array has only one element,
        // we are already at the last index.
        if (arr.size == 1) return 0

        // Map each value to all indices where it appears.
        // Example:
        // 100 -> [0, 4]
        // -23 -> [1, 2]
        val graph = HashMap<Int, MutableList<Int>>()

        for (i in arr.indices) {
            graph.computeIfAbsent(arr[i]) { mutableListOf() }.add(i)
        }

        // BFS queue
        val queue: ArrayDeque<Int> = ArrayDeque()

        // Visited array to avoid revisiting indices
        val visited = BooleanArray(arr.size)

        // Start from index 0
        queue.add(0)
        visited[0] = true

        // Number of jumps taken
        var steps = 0

        // Standard BFS
        while (queue.isNotEmpty()) {

            // Process one BFS level at a time
            val size = queue.size

            repeat(size) {

                val current = queue.removeFirst()

                // If we reached last index
                if (current == arr.lastIndex) {
                    return steps
                }

                // -------------------------------------------------
                // 1. Jump to current - 1
                // -------------------------------------------------
                val left = current - 1

                if (left >= 0 && !visited[left]) {
                    visited[left] = true
                    queue.add(left)
                }

                // -------------------------------------------------
                // 2. Jump to current + 1
                // -------------------------------------------------
                val right = current + 1

                if (right < arr.size && !visited[right]) {
                    visited[right] = true
                    queue.add(right)
                }

                // -------------------------------------------------
                // 3. Jump to all indices with same value
                // -------------------------------------------------
                val sameValueIndices = graph[arr[current]]

                if (sameValueIndices != null) {

                    for (next in sameValueIndices) {

                        if (!visited[next]) {
                            visited[next] = true
                            queue.add(next)
                        }
                    }

                    // IMPORTANT OPTIMIZATION
                    //
                    // Once we've processed all indices for a value,
                    // we clear the list so we never process them again.
                    //
                    // Without this, the solution becomes too slow
                    // for large inputs.
                    graph.remove(arr[current])
                }
            }

            // After finishing one BFS layer,
            // increment steps (number of jumps)
            steps++
        }

        return -1
    }
}