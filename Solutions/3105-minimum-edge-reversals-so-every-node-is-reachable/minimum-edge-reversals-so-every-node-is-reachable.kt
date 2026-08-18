class Solution {
    fun minEdgeReversals(n: Int, edges: Array<IntArray>): IntArray {

        // ------------------------------------------------------------
        // We treat the original directed edges as a tree where every
        // edge can be traversed in either direction for DFS purposes.
        //
        // For every connection, we store:
        //
        //     neighbor
        //     cost
        //
        // cost = 0:
        //     The original edge already points from current -> neighbor.
        //
        //     Example:
        //         current -----> neighbor
        //
        //     No reversal is needed to move from current to neighbor.
        //
        // cost = 1:
        //     The original edge points from neighbor -> current.
        //
        //     Example:
        //         current <----- neighbor
        //
        //     We would need to reverse this edge to move from
        //     current to neighbor.
        // ------------------------------------------------------------

        val graph = Array(n) {
            mutableListOf<Pair<Int, Int>>()
        }

        // Build the undirected representation of the tree.
        for (edge in edges) {

            val u = edge[0]
            val v = edge[1]

            // Original direction is:
            //
            //     u -> v
            //
            // So when we travel from u to v, no reversal is needed.
            graph[u].add(Pair(v, 0))

            // When traveling from v to u, the original edge points
            // in the opposite direction.
            //
            // Therefore, we would need one reversal.
            graph[v].add(Pair(u, 1))
        }

        // answer[i] will eventually contain the minimum number
        // of reversals needed when starting from node i.
        val answer = IntArray(n)

        // ------------------------------------------------------------
        // FIRST DFS
        // ------------------------------------------------------------
        //
        // Root the tree at node 0.
        //
        // To be able to reach every node starting from 0,
        // every edge needs to point away from node 0.
        //
        // We calculate how many reversals are necessary to make
        // that happen.
        //
        // The result will be answer[0].
        // ------------------------------------------------------------

        var reversalsForZero = 0

        // We use an iterative DFS instead of recursion.
        //
        // Kotlin recursion can cause StackOverflowError for
        // a tree containing up to 100,000 nodes.
        val stack = java.util.ArrayDeque<Int>()

        // Keep track of the parent of every node so that we don't
        // travel backwards through the tree.
        val parent = IntArray(n) {
            -1
        }

        // Start DFS from node 0.
        stack.addLast(0)
        parent[0] = 0

        while (stack.isNotEmpty()) {

            val node = stack.removeLast()

            for ((neighbor, cost) in graph[node]) {

                // Don't go back to the parent.
                if (neighbor == parent[node]) {
                    continue
                }

                // Remember the parent so that the tree traversal
                // doesn't go backwards.
                parent[neighbor] = node

                // If cost == 1, the edge currently points toward
                // the current node instead of away from it.
                //
                // Therefore, this edge needs to be reversed.
                reversalsForZero += cost

                // Continue DFS from this neighbor.
                stack.addLast(neighbor)
            }
        }

        // We now know the answer for node 0.
        answer[0] = reversalsForZero

        // ------------------------------------------------------------
        // SECOND DFS: REROOTING
        // ------------------------------------------------------------
        //
        // Now comes the important trick.
        //
        // Suppose we know answer[u], and we move the starting
        // node from u to its neighbor v.
        //
        // Only ONE edge changes its relationship with the root:
        //
        //             u ---- v
        //
        // Therefore, answer[v] can be calculated from answer[u]
        // in O(1).
        //
        // We don't need to recalculate the entire tree.
        // ------------------------------------------------------------

        stack.clear()

        stack.addLast(0)

        while (stack.isNotEmpty()) {

            val node = stack.removeLast()

            for ((neighbor, cost) in graph[node]) {

                // Don't go back toward the parent.
                if (neighbor == parent[node]) {
                    continue
                }

                // ----------------------------------------------------
                // REROOTING FORMULA
                // ----------------------------------------------------
                //
                // cost == 0 means the original edge is:
                //
                //     node -> neighbor
                //
                // When node is the root, this direction is already
                // correct, so we didn't need to reverse it.
                //
                // But when neighbor becomes the root, we need:
                //
                //     neighbor -> node
                //
                // Therefore, we now need ONE additional reversal.
                //
                // Change:
                //     +1
                //
                //
                // cost == 1 means the original edge is:
                //
                //     neighbor -> node
                //
                // When node is the root, we needed to reverse it.
                //
                // But when neighbor becomes the root, the original
                // direction is already correct.
                //
                // Therefore, we SAVE one reversal.
                //
                // Change:
                //     -1
                //
                //
                // Both cases can be written as:
                //
                //     answer[neighbor] =
                //         answer[node] + 1 - 2 * cost
                //
                // If cost = 0:
                //     answer[neighbor] = answer[node] + 1
                //
                // If cost = 1:
                //     answer[neighbor] = answer[node] - 1
                // ----------------------------------------------------

                answer[neighbor] =
                    answer[node] + 1 - 2 * cost

                // Continue rerooting through the tree.
                stack.addLast(neighbor)
            }
        }

        return answer
    }
}