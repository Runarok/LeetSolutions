class Solution {

    /**
     * Given two trees and an integer k, for each node i in tree1,
     * find the maximum number of nodes target to i after connecting i
     * to some node in tree2 by a new edge.
     *
     * @param Integer[][] $edges1 Edges of the first tree with n nodes.
     * @param Integer[][] $edges2 Edges of the second tree with m nodes.
     * @param Integer $k Maximum allowed distance for "target" relation.
     * @return Integer[] Array of length n with answers for each node i in tree1.
     */
    function maxTargetNodes($edges1, $edges2, $k) {
        // Number of nodes in tree1 and tree2
        $n = count($edges1) + 1;  // Since tree with n nodes has n-1 edges
        $m = count($edges2) + 1;

        // Step 1: Build adjacency lists for both trees to easily do BFS
        // Each element adj1[i] will hold a list of nodes connected to node i in tree1
        $adj1 = array_fill(0, $n, []);
        foreach ($edges1 as $e) {
            $adj1[$e[0]][] = $e[1];
            $adj1[$e[1]][] = $e[0];
        }

        // Similarly for tree2
        $adj2 = array_fill(0, $m, []);
        foreach ($edges2 as $e) {
            $adj2[$e[0]][] = $e[1];
            $adj2[$e[1]][] = $e[0];
        }

        // Step 2: Define a BFS function to find shortest distances from a start node to all nodes
        // It returns an array dist where dist[x] is distance from start to node x (or -1 if unreachable)
        $bfs = function($adj, $start) {
            $dist = array_fill(0, count($adj), -1); // Initialize distances as -1 (unvisited)
            $dist[$start] = 0;  // Distance to start node is 0
            $queue = [$start];
            $head = 0;
            while ($head < count($queue)) {
                $u = $queue[$head++];
                foreach ($adj[$u] as $v) {
                    if ($dist[$v] === -1) {
                        $dist[$v] = $dist[$u] + 1;  // Distance increases by 1 edge
                        $queue[] = $v;
                    }
                }
            }
            return $dist;
        };

        // Step 3: Compute all pairwise distances inside tree1 by BFS from every node
        // dist1[i][x] = shortest distance from node i to node x in tree1
        $dist1 = [];
        for ($i = 0; $i < $n; $i++) {
            $dist1[$i] = $bfs($adj1, $i);
        }

        // Step 4: Compute all pairwise distances inside tree2 by BFS from every node
        // dist2[j][x] = shortest distance from node j to node x in tree2
        $dist2 = [];
        for ($j = 0; $j < $m; $j++) {
            $dist2[$j] = $bfs($adj2, $j);
        }

        // Step 5: For each node in tree2, precompute a prefix array counting how many nodes
        // are reachable within distance d, for d=0 to k.
        // This allows O(1) queries later: how many nodes are within distance d from node j in tree2.
        $maxDist2 = [];  // Will hold prefix sums for each node in tree2
        for ($j = 0; $j < $m; $j++) {
            // Initialize an array of counts for distances from 0 to k
            $countWithin = array_fill(0, $k + 1, 0);

            // Count nodes with distances <= k from node j
            foreach ($dist2[$j] as $d) {
                if ($d !== -1 && $d <= $k) {
                    $countWithin[$d]++;
                }
            }

            // Convert counts into prefix sums:
            // countWithin[d] = number of nodes with distance <= d
            for ($d = 1; $d <= $k; $d++) {
                $countWithin[$d] += $countWithin[$d - 1];
            }

            // Store prefix sums for this node j in tree2
            $maxDist2[$j] = $countWithin;
        }

        // Step 6: Now compute the answer for each node i in tree1
        // For each i:
        // - Count how many nodes in tree1 are within distance k of i (fixed, since tree1 not changing)
        // - For each node j in tree2, calculate how many nodes in tree2 are within distance (k-1) of j,
        //   since connecting i to j adds 1 edge between trees, so total distance to nodes in tree2
        //   from i is 1 + distance(j, node)
        // - Pick the j that maximizes the reachable nodes in tree2
        // - Sum the two counts to get the answer for node i

        $answer = array_fill(0, $n, 0);

        for ($i = 0; $i < $n; $i++) {
            // Count nodes reachable in tree1 from i within distance k
            $count1 = 0;
            foreach ($dist1[$i] as $d) {
                if ($d !== -1 && $d <= $k) {
                    $count1++;
                }
            }

            // Find best node j in tree2 to connect to
            $best = 0;
            $maxAllowed = $k - 1;  // max allowed distance in tree2 nodes from chosen j

            if ($maxAllowed < 0) {
                // If k = 0, no node in tree2 can be reached through the connecting edge
                // (distance to nodes in tree2 would be 1 + something, which is > 0)
                $best = 0;
            } else {
                // Check every node j in tree2
                for ($j = 0; $j < $m; $j++) {
                    // maxDist2[$j][$maxAllowed] = number of nodes in tree2 within distance maxAllowed from j
                    $reachable = $maxDist2[$j][$maxAllowed];
                    if ($reachable > $best) {
                        $best = $reachable;
                    }
                }
            }

            // Total reachable nodes target to i after connecting best j from tree2
            $answer[$i] = $count1 + $best;
        }

        return $answer;
    }
}
