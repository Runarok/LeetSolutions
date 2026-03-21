class Solution {
    
    // Adjacency list representation of the tree
    // Each entry: graph[node] = list of {childNode, bitIndex}
    List<int []> [] graph;
    
    // Stores the bitmask value (parity of characters from root to that node)
    int [] nodeVals;
    
    // Map to store frequency of each bitmask encountered during DFS
    Map<Integer, Integer> map;
    
    public long countPalindromePaths(List<Integer> parent, String s) {
        int n = parent.size();
        
        // Initialize graph with n nodes
        graph = new List[n];
        
        for (int i = 0; i < n; ++i) {
            graph[i] = new ArrayList<>();
        }
        
        // Build the tree
        // parent[i] gives the parent of node i
        // Edge stores child node and the character's bit index
        for (int i = 1; i < n; ++i) {
            graph[parent.get(i)].add(
                new int [] { i, s.charAt(i) - 'a' }
            );
        }
        
        // Stores the XOR bitmask for each node
        // Each bit represents whether a character appears odd (1) or even (0) times
        nodeVals = new int [n];
        
        // Frequency map of bitmasks encountered during DFS traversal
        map = new HashMap<>();
        
        // Run DFS starting from root node (0) with initial mask = 0
        dfs(0, 0);
        
        long total = 0;
        
        // Iterate over all nodes and count valid palindrome paths ending at each node
        for (int i = 0; i < n; ++i) {
            int current = nodeVals[i];
            
            // Case 1: Paths where the XOR mask is exactly the same
            // This means all characters occur even times → valid palindrome
            long val = map.get(current) - 1; // subtract 1 to exclude the node itself
            
            // Case 2: Paths where exactly one character has odd frequency
            // Try flipping each bit and check if such a mask exists
            for (int j = 0; j < 26; ++j) {  // 26 letters a-z
                int nCurrent = current ^ (1 << j);
                
                // Add frequency of this flipped mask
                val += map.getOrDefault(nCurrent, 0);
            }
            
            total += val;
        }
        
        // Each path is counted twice (once from each endpoint), so divide by 2
        return total / 2;
    }
    
    /**
     * DFS traversal to compute bitmask for each node.
     *
     * @param node current node
     * @param val  current bitmask representing path from root to this node
     */
    private void dfs(int node, int val) {
        // Store the bitmask value for this node
        nodeVals[node] = val;
        
        // Add this mask to the frequency map
        map.put(val, map.getOrDefault(val, 0) + 1);
        
        // Traverse all children of the current node
        for (int [] next : graph[node]) {
            int nextNode = next[0];
            int nextBit = next[1];
            
            // Toggle the bit corresponding to the character at next node
            // XOR flips the bit:
            // - if character appears odd number of times → bit = 1
            // - if even → bit = 0
            dfs(nextNode, val ^ (1 << nextBit));
        }
    }
}