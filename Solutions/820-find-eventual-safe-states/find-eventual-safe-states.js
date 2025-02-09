/**
 * @param {number[][]} graph
 * @return {number[]}
 */
var eventualSafeNodes = function(graph) {
    const n = graph.length;
    const safe = new Array(n).fill(0); // 0 = unvisited, 1 = safe, 2 = unsafe
    
    const dfs = (node) => {
        if (safe[node] !== 0) return safe[node]; // If already visited, return the result
        safe[node] = 2; // Mark as unsafe by default
        
        for (let neighbor of graph[node]) {
            if (dfs(neighbor) === 2) { // If any neighbor is unsafe
                return safe[node]; // Mark this node as unsafe
            }
        }
        
        safe[node] = 1; // Mark the node as safe
        return 1;
    };
    
    // Perform DFS for each node
    for (let i = 0; i < n; i++) {
        if (safe[i] === 0) {
            dfs(i);
        }
    }
    
    // Collect and return all safe nodes
    const result = [];
    for (let i = 0; i < n; i++) {
        if (safe[i] === 1) {
            result.push(i);
        }
    }
    
    return result;
};
