var checkIfPrerequisite = function(numCourses, prerequisites, queries) {
    // Initialize a 2D array where reachable[i][j] is true if i is a prerequisite of j
    const reachable = Array.from({ length: numCourses }, () => Array(numCourses).fill(false));

    // Fill in the graph based on prerequisites
    for (const [a, b] of prerequisites) {
        reachable[a][b] = true;
    }

    // Use the Floyd-Warshall algorithm to compute the transitive closure
    for (let k = 0; k < numCourses; k++) {
        for (let i = 0; i < numCourses; i++) {
            for (let j = 0; j < numCourses; j++) {
                // If i can reach k and k can reach j, then i can reach j
                reachable[i][j] = reachable[i][j] || (reachable[i][k] && reachable[k][j]);
            }
        }
    }

    // Answer the queries based on the transitive closure
    const result = [];
    for (const [u, v] of queries) {
        result.push(reachable[u][v]);
    }

    return result;
};
