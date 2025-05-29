class Solution {

    /**
     * @param Integer[][] $edges1
     * @param Integer[][] $edges2
     * @return Integer[]
     */
    function maxTargetNodes($edges1, $edges2) {
        $n = count($edges1) + 1;  // number of nodes in tree 1
        $m = count($edges2) + 1;  // number of nodes in tree 2
        
        // Arrays to hold parity/color of each node (0 or 1) based on depth parity
        $color1 = array_fill(0, $n, 0);
        $color2 = array_fill(0, $m, 0);
        
        // Build trees and count parity groups
        $count1 = $this->buildAndCount($edges1, $color1);
        $count2 = $this->buildAndCount($edges2, $color2);
        
        $result = [];
        
        // For each node i in Tree 1:
        // The answer is:
        // number of nodes in Tree 1 that have the same parity as node i
        // plus the maximum number of nodes in either parity group of Tree 2
        for ($i = 0; $i < $n; $i++) {
            $res = $count1[$color1[$i]] + max($count2[0], $count2[1]);
            $result[] = $res;
        }
        
        return $result;
    }
    
    /**
     * Build adjacency list, run DFS from node 0 to assign parity colors,
     * and count how many nodes have color 0 and color 1.
     * 
     * @param Integer[][] $edges
     * @param int[] &$color output parameter to hold parity colors for nodes
     * @return int[] array with two elements: count of nodes with color 0 and color 1
     */
    private function buildAndCount($edges, &$color) {
        $n = count($edges) + 1;
        $adj = array_fill(0, $n, []);
        
        // Build adjacency list
        foreach ($edges as $e) {
            $adj[$e[0]][] = $e[1];
            $adj[$e[1]][] = $e[0];
        }
        
        // Run DFS to assign parity colors and count nodes with color 0 and 1
        $count = [0, 0];  // counts of color 0 and color 1 nodes
        
        // Start DFS from node 0, depth 0 (even parity)
        $this->dfs(0, -1, 0, $adj, $color, $count);
        
        return $count;
    }
    
    /**
     * Depth-First Search to assign parity colors and count them
     * 
     * @param int $node current node
     * @param int $parent parent node in DFS (to avoid going back)
     * @param int $depth current depth (distance from root)
     * @param array $adj adjacency list of the tree
     * @param int[] &$color array to assign parity colors
     * @param int[] &$count counts of parity 0 and 1 nodes
     * @return void
     */
    private function dfs($node, $parent, $depth, &$adj, &$color, &$count) {
        // parity color: 0 if even depth, 1 if odd depth
        $color[$node] = $depth % 2;
        
        // Increment count for this parity group
        $count[$color[$node]]++;
        
        // Visit all neighbors except parent
        foreach ($adj[$node] as $nei) {
            if ($nei === $parent) continue;  // skip going back
            
            $this->dfs($nei, $node, $depth + 1, $adj, $color, $count);
        }
    }
}
