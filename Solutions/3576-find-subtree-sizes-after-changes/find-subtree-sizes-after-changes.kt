
class Solution {
    fun findSubtreeSizes(parent: IntArray, s: String): IntArray {

        // Number of nodes in the tree
        val n = parent.size

        // --------------------------------------------------
        // STEP 1: Build the original tree
        // --------------------------------------------------

        // children[i] contains all direct children of node i
        val children = Array(n) { mutableListOf<Int>() }

        for (i in 1 until n) {
            children[parent[i]].add(i)
        }

        // --------------------------------------------------
        // STEP 2: Find the closest matching ancestor
        // --------------------------------------------------

        // lastSeen[c] stores the closest ancestor having
        // character c on the current DFS path.
        //
        // -1 means no such ancestor exists.
        val lastSeen = IntArray(26) { -1 }

        // DFS on the ORIGINAL tree.
        fun dfs(node: Int) {

            // Convert the current character into an index.
            // 'a' -> 0, 'b' -> 1, ..., 'z' -> 25
            val charIndex = s[node] - 'a'

            // Remember the previous closest ancestor
            // having the same character.
            val previous = lastSeen[charIndex]

            // If a matching ancestor exists,
            // make it the new parent of this node.
            if (previous != -1) {
                parent[node] = previous
            }

            // The current node becomes the closest
            // ancestor for its character.
            lastSeen[charIndex] = node

            // Visit all children in the ORIGINAL tree.
            //
            // Important:
            // We must use the original children array here.
            // Parent changes must not affect this traversal.
            for (child in children[node]) {
                dfs(child)
            }

            // Backtracking:
            // Restore the previous ancestor information.
            //
            // This ensures that sibling branches do not
            // interfere with each other.
            lastSeen[charIndex] = previous
        }

        // Start DFS from the root.
        dfs(0)

        // --------------------------------------------------
        // STEP 3: Build the MODIFIED tree
        // --------------------------------------------------

        // Create a new adjacency list using updated parents.
        val newChildren = Array(n) { mutableListOf<Int>() }

        for (i in 1 until n) {
            newChildren[parent[i]].add(i)
        }

        // --------------------------------------------------
        // STEP 4: Calculate subtree sizes
        // --------------------------------------------------

        // answer[i] will store the subtree size of node i.
        val answer = IntArray(n)

        // DFS to calculate subtree sizes in the new tree.
        fun calculateSubtree(node: Int): Int {

            // Every node is part of its own subtree.
            var size = 1

            // Add the subtree sizes of all children.
            for (child in newChildren[node]) {
                size += calculateSubtree(child)
            }

            // Store the calculated subtree size.
            answer[node] = size

            // Return this subtree's size to the parent.
            return size
        }

        // Start calculating from the root.
        calculateSubtree(0)

        return answer
    }
}
