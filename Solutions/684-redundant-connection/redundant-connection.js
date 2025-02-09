/**
 * @param {number[][]} edges
 * @return {number[]}
 */
var findRedundantConnection = function(edges) {
    // Helper functions for Union-Find (Disjoint Set Union)
    const find = (parent, node) => {
        if (parent[node] !== node) {
            parent[node] = find(parent, parent[node]); // Path compression
        }
        return parent[node];
    };

    const union = (parent, rank, node1, node2) => {
        const root1 = find(parent, node1);
        const root2 = find(parent, node2);
        
        if (root1 !== root2) {
            // Union by rank
            if (rank[root1] > rank[root2]) {
                parent[root2] = root1;
            } else if (rank[root1] < rank[root2]) {
                parent[root1] = root2;
            } else {
                parent[root2] = root1;
                rank[root1]++;
            }
        } else {
            return true; // Cycle detected
        }
        return false; // No cycle
    };

    // Initialize parent and rank arrays for Union-Find
    const n = edges.length;
    const parent = Array(n + 1).fill(0).map((_, idx) => idx); // parent[i] points to parent of i
    const rank = Array(n + 1).fill(0); // rank to keep tree shallow

    for (let edge of edges) {
        const [a, b] = edge;
        if (union(parent, rank, a, b)) {
            return edge; // This edge forms a cycle
        }
    }
};
