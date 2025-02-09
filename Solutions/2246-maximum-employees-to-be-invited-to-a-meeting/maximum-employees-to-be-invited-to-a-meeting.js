/**
 * @param {number[]} favorite
 * @return {number}
 */
var maximumInvitations = function(A) {
    const N = A.length;
    const m = Array(N).fill(-1); // m[i] is the depth of node i, -1 means unvisited
    const r = Array.from({ length: N }, () => []); // Reverse graph

    // Construct the reverse graph
    for (let i = 0; i < N; ++i) {
        r[A[i]].push(i);
    }

    // DFS to calculate the depth (longest path) from node u
    function dfs(u) {
        if (m[u] !== -1) return m[u];
        let ans = 0;
        for (let v of r[u]) {
            ans = Math.max(ans, dfs(v));
        }
        return m[u] = 1 + ans;
    }

    let ans = 0, free = 0;

    // Handle case 1: Pairing of employees who have each other as favorites
    for (let i = 0; i < N; ++i) {
        if (m[i] !== -1) continue; // Skip visited nodes
        if (A[A[i]] === i) {
            m[i] = m[A[i]] = 0; // Mark both nodes of the pair as visited
            let a = 0, b = 0;

            // Find the longest arm starting from i, excluding A[i]
            for (let v of r[i]) {
                if (v === A[i]) continue;
                a = Math.max(a, dfs(v));
            }

            // Find the longest arm starting from A[i], excluding i
            for (let v of r[A[i]]) {
                if (v === i) continue;
                b = Math.max(b, dfs(v));
            }

            // This free component is of length a + b + 2
            free += a + b + 2;
        }
    }

    // Handle case 2: Find the cycle length for each unvisited node
    function dfs2(u) {
        if (m[u] !== -1) return [u, m[u], false]; // If already visited, it's part of the cycle

        m[u] = 0;
        const [entryPoint, depth, cycleVisited] = dfs2(A[u]);
        if (cycleVisited) {
            return [entryPoint, depth, true];
        }

        m[u] = 1 + depth; // If we haven't met the entry point again, this is a node within the cycle
        return [entryPoint, m[u], u === entryPoint]; // Return cycle entry point and cycle depth
    }

    // Traverse all nodes to find the maximum cycle length
    for (let i = 0; i < N; ++i) {
        if (m[i] !== -1) continue;
        const [entryPoint, depth, cycleVisited] = dfs2(i);
        if (cycleVisited) {
            ans = Math.max(ans, depth);
        }
    }

    return Math.max(ans, free); // Return the maximum of both cases
};
