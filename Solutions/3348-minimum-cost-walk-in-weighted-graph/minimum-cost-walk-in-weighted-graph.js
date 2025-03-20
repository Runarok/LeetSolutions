/**
 * @param {number} n
 * @param {number[][]} edges
 * @param {number[][]} query
 * @return {number[]}
 */
var minimumCost = function(n, edges, queries) {
    // Step 1: Create the adjacency list for the graph
    const adjList = Array.from({ length: n }, () => []);
    for (let [u, v, w] of edges) {
        adjList[u].push([v, w]);
        adjList[v].push([u, w]);
    }

    // Step 2: Arrays to store visited nodes and component IDs
    const visited = new Array(n).fill(false);
    const components = new Array(n).fill(-1);  // -1 indicates unvisited nodes

    // Array to store the cost of each component
    const componentCost = [];
    let componentId = 0;

    // Step 3: Perform BFS for each unvisited node to identify components and calculate costs
    const bfs = (source, componentId) => {
        const queue = [source];
        visited[source] = true;
        components[source] = componentId;
        let componentCostValue = -1;  // Start with all 1s in binary representation

        while (queue.length > 0) {
            const node = queue.shift();
            for (let [neighbor, weight] of adjList[node]) {
                // Update the component cost by performing a bitwise AND of the edge weights
                componentCostValue &= weight;

                // If the neighbor hasn't been visited, mark it and add to the queue
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    components[neighbor] = componentId;
                    queue.push(neighbor);
                }
            }
        }

        // Store the computed cost for this component
        return componentCostValue;
    };

    // Step 4: Identify all components and compute the cost for each component
    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            componentCost.push(bfs(i, componentId));
            componentId++;
        }
    }

    // Step 5: Process each query
    const result = [];
    for (let [start, end] of queries) {
        if (components[start] === components[end]) {
            // If the nodes are in the same component, return the precomputed cost
            result.push(componentCost[components[start]]);
        } else {
            // If the nodes are in different components, return -1
            result.push(-1);
        }
    }

    return result;
};
