/**
 * @param {number} n
 * @param {number[][]} edges
 * @return {number}
 */

var countCompleteComponents = function(n, edges) {
    // Step 1: Build the adjacency list representation of the graph
    let adj = Array.from({ length: n }, () => new Set());
    for (let [u, v] of edges) {
        adj[u].add(v);  // Add v as a neighbor of u
        adj[v].add(u);  // Add u as a neighbor of v
    }

    // Step 2: DFS function to explore all nodes in a connected component
    const dfs = (node, visited, component) => {
        visited[node] = true;  // Mark this node as visited
        component.push(node);  // Add the node to the current component
        for (let neighbor of adj[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, visited, component);  // Recursively visit all unvisited neighbors
            }
        }
    };

    // Step 3: Check if a component is complete
    const isComplete = (component) => {
        let k = component.length;  // Number of nodes in the component
        let expectedEdges = (k * (k - 1)) / 2;  // Expected number of edges for a complete graph
        let actualEdges = 0;  // Actual number of edges in this component

        // Count the edges between all pairs of nodes in the component
        for (let i = 0; i < k; i++) {
            for (let j = i + 1; j < k; j++) {
                if (adj[component[i]].has(component[j])) {
                    actualEdges++;  // Increment if there's an edge between component[i] and component[j]
                }
            }
        }

        // If the number of edges matches the expected number, it's a complete component
        return actualEdges === expectedEdges;
    };

    // Step 4: Explore the graph and count the number of complete components
    let visited = Array(n).fill(false);  // Array to track visited nodes
    let completeCount = 0;  // Counter for complete components

    // Iterate through all nodes to find connected components
    for (let i = 0; i < n; i++) {
        if (!visited[i]) {  // If the node is not visited yet
            let component = [];  // Array to store the current component's nodes
            dfs(i, visited, component);  // Run DFS to find all nodes in this component
            if (isComplete(component)) {  // Check if the component is complete
                completeCount++;  // Increment count if the component is complete
            }
        }
    }

    // Return the total number of complete connected components
    return completeCount;
};
