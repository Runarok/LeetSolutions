class Solution {

    /**
     * @param String $colors
     * @param Integer[][] $edges
     * @return Integer
     */
    function largestPathValue($colors, $edges) {
        $n = strlen($colors);  // Number of nodes

        // Step 1: Build graph adjacency list and in-degree array
        // graph[i] will store all nodes that i points to
        $graph = array_fill(0, $n, []);
        // inDegree[i] stores how many edges come into node i
        $inDegree = array_fill(0, $n, 0);
        
        // Build graph and in-degree counts from edges
        foreach ($edges as [$a, $b]) {
            $graph[$a][] = $b;    // Add edge from a to b
            $inDegree[$b]++;      // Increment in-degree for node b
        }

        // Step 2: Initialize queue with all nodes that have zero in-degree (no dependencies)
        $queue = [];
        for ($i = 0; $i < $n; $i++) {
            if ($inDegree[$i] === 0) {
                $queue[] = $i;
            }
        }

        // Step 3: Prepare DP array to store color counts along paths
        // dp[node][color] = max number of times 'color' appears on any path ending at 'node'
        // Since colors are 'a' to 'z', we use 26-length arrays
        $dp = array_fill(0, $n, array_fill(0, 26, 0));

        $maxColorValue = 0;  // Will hold the max count of any color on any path
        $visitedCount = 0;   // Count how many nodes we process (to detect cycles)

        // Step 4: Process nodes in topological order
        while (!empty($queue)) {
            // Pop the front node from the queue
            $node = array_shift($queue);
            $visitedCount++;

            // Find the color index for current node's color
            $colorIndex = ord($colors[$node]) - ord('a');

            // Increment the count of this node's color for the path ending here
            $dp[$node][$colorIndex]++;

            // Update global maximum if this count is larger
            $maxColorValue = max($maxColorValue, $dp[$node][$colorIndex]);

            // Step 5: Propagate DP counts to all neighbors
            foreach ($graph[$node] as $next) {
                // For each color, update the neighbor's dp if current path offers more counts
                for ($c = 0; $c < 26; $c++) {
                    if ($dp[$node][$c] > $dp[$next][$c]) {
                        $dp[$next][$c] = $dp[$node][$c];
                    }
                }

                // Decrement in-degree for neighbor since we processed one incoming edge
                $inDegree[$next]--;

                // If neighbor has no more incoming edges, add it to queue to process next
                if ($inDegree[$next] === 0) {
                    $queue[] = $next;
                }
            }
        }

        // Step 6: Check if all nodes were processed
        // If not, the graph contains a cycle, so return -1
        if ($visitedCount !== $n) {
            return -1;
        }

        // Step 7: Return the maximum color count found on any path
        return $maxColorValue;
    }
}
