
class Solution {

    /**
     * Perform a BFS-like traversal (actually a simple linear walk because each node has at most one outgoing edge)
     * to compute the shortest distances from the start node to all other nodes reachable in the graph.
     *
     * @param int $startNode The node from which distances are calculated
     * @param array $edges The graph edges array
     * @param array &$dist Reference to the distance array to update
     * 
     * Explanation:
     * Each node has at most one outgoing edge, so this is effectively a walk along edges until
     * no more nodes or a cycle is detected.
     */
    private function bfs(int $startNode, array $edges, array &$dist): void {
        $n = count($edges);

        // Initialize visited array to avoid cycles and repeated processing
        $visited = array_fill(0, $n, false);

        // Initialize distance for the startNode as 0
        $dist[$startNode] = 0;

        // Current node to explore starts from startNode
        $current = $startNode;

        // Walk through nodes until we reach a node with no outgoing edge or a cycle
        while ($current != -1 && !$visited[$current]) {
            $visited[$current] = true;

            $neighbor = $edges[$current];

            // If neighbor is valid and not visited, update its distance
            if ($neighbor != -1 && !$visited[$neighbor]) {
                $dist[$neighbor] = $dist[$current] + 1;
            }

            // Move to the neighbor node
            $current = $neighbor;
        }
    }

    /**
     * Finds the closest meeting node reachable from both node1 and node2.
     * Returns the node with minimum max distance from node1 and node2.
     *
     * @param Integer[] $edges Directed graph edges, where each node points to at most one node
     * @param Integer $node1 Starting node 1
     * @param Integer $node2 Starting node 2
     * @return Integer Index of the closest meeting node or -1 if none exists
     */
    function closestMeetingNode(array $edges, int $node1, int $node2): int {
        $n = count($edges);

        // Initialize distance arrays with a large number to represent infinity/unreachable nodes
        $dist1 = array_fill(0, $n, PHP_INT_MAX);
        $dist2 = array_fill(0, $n, PHP_INT_MAX);

        // Compute shortest distances from node1 and node2
        $this->bfs($node1, $edges, $dist1);
        $this->bfs($node2, $edges, $dist2);

        $minDistNode = -1;
        $minDistTillNow = PHP_INT_MAX;

        // Iterate over all nodes to find the one minimizing the maximum distance from node1 and node2
        for ($currNode = 0; $currNode < $n; $currNode++) {
            // Find max distance to currNode from both node1 and node2
            $maxDist = max($dist1[$currNode], $dist2[$currNode]);

            // Only consider nodes reachable from both nodes (distances not infinite)
            if ($dist1[$currNode] != PHP_INT_MAX && $dist2[$currNode] != PHP_INT_MAX) {
                // Update answer if current max distance is smaller or equal with smaller index node
                if ($maxDist < $minDistTillNow || ($maxDist == $minDistTillNow && $currNode < $minDistNode)) {
                    $minDistNode = $currNode;
                    $minDistTillNow = $maxDist;
                }
            }
        }

        return $minDistNode;
    }
}
