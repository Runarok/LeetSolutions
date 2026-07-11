class Solution {

    /**
     * @param Integer $n
     * @param Integer[][] $edges
     * @return Integer
     */
    function countCompleteComponents($n, $edges) {

        // -----------------------------
        // Build adjacency list
        // -----------------------------
        $graph = array_fill(0, $n, []);

        foreach ($edges as $edge) {
            $u = $edge[0];
            $v = $edge[1];

            // Since graph is undirected,
            // add both directions
            $graph[$u][] = $v;
            $graph[$v][] = $u;
        }

        // Keeps track of visited vertices
        $visited = array_fill(0, $n, false);

        // Final answer
        $completeComponents = 0;

        // Try to start DFS from every vertex
        for ($i = 0; $i < $n; $i++) {

            // Skip if already belongs to a processed component
            if ($visited[$i]) {
                continue;
            }

            // Stack for iterative DFS
            $stack = [$i];

            // Number of vertices in this component
            $vertexCount = 0;

            // Sum of degrees of all vertices
            $degreeSum = 0;

            // DFS traversal
            while (!empty($stack)) {

                $node = array_pop($stack);

                // Ignore if already visited
                if ($visited[$node]) {
                    continue;
                }

                // Mark visited
                $visited[$node] = true;

                // One more vertex discovered
                $vertexCount++;

                // Degree = number of neighbors
                $degreeSum += count($graph[$node]);

                // Visit all neighbors
                foreach ($graph[$node] as $neighbor) {
                    if (!$visited[$neighbor]) {
                        $stack[] = $neighbor;
                    }
                }
            }

            // ---------------------------------------
            // Complete graph check
            //
            // k vertices
            // Expected edges = k*(k-1)/2
            //
            // Degree sum = 2 * edges
            // Therefore expected degree sum:
            // k*(k-1)
            // ---------------------------------------
            if ($degreeSum == $vertexCount * ($vertexCount - 1)) {
                $completeComponents++;
            }
        }

        return $completeComponents;
    }
}