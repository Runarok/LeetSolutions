object Solution {
    def maxKDivisibleComponents(n: Int, edges: Array[Array[Int]], values: Array[Int], k: Int): Int = {

        // ------------------------------------------------------------
        // 1. Build adjacency list for the tree
        // ------------------------------------------------------------
        val graph = Array.fill[List[Int]](n)(Nil)
        edges.foreach { e =>
            val a = e(0)
            val b = e(1)
            graph(a) = b :: graph(a)
            graph(b) = a :: graph(b)
        }

        // This variable counts how many valid components we form.
        // Every time a subtree sum % k == 0, that subtree becomes a component.
        var components = 0

        // ------------------------------------------------------------
        // 2. DFS function returns the sum of the subtree modulo k
        // ------------------------------------------------------------
        def dfs(node: Int, parent: Int): Long = {

            // start with its own value
            var sum: Long = values(node).toLong

            // explore children (all neighbors except parent)
            for (nbr <- graph(node) if nbr != parent) {
                val childSum = dfs(nbr, node)

                // Combine child's remainder with current sum
                // Only keep remainder % k to avoid overflow
                sum = (sum + childSum) % k
            }

            // If the sum of this subtree is divisible by k,
            // we can cut this edge and treat it as a component.
            if (sum % k == 0) {
                components += 1
                return 0   // return 0 upward, since this subtree is already extracted
            }

            sum
        }

        // Start DFS from root = 0 (any node works, tree is undirected)
        dfs(0, -1)

        components
    }
}
