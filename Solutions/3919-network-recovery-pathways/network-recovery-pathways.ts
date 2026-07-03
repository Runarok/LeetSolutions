function findMaxPathScore(edges: number[][], online: boolean[], k: number): number {
    const n = online.length;

    // Adjacency list: graph[u] = [v, edgeCost]
    const graph: [number, number][][] = Array.from({ length: n }, () => []);

    // Stores indegree of every node (needed for topological sort)
    const indegree = new Array(n).fill(0);

    // Largest edge cost (binary search upper bound)
    let maxCost = 0;

    // Build graph
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        indegree[v]++;
        maxCost = Math.max(maxCost, w);
    }

    // ---------------- Topological Sort ----------------

    const queue: number[] = [];

    // Start with nodes having indegree 0
    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) queue.push(i);
    }

    const topo: number[] = [];
    let head = 0;

    while (head < queue.length) {
        const u = queue[head++];
        topo.push(u);

        // Remove outgoing edges
        for (const [v] of graph[u]) {
            indegree[v]--;

            if (indegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    // Checks if there exists a valid path whose minimum edge >= limit
    const check = (limit: number): boolean => {
        const INF = Number.MAX_SAFE_INTEGER;

        // dist[i] = minimum total cost to reach node i
        const dist = new Array<number>(n).fill(INF);
        dist[0] = 0;

        // Process nodes in topological order
        for (const u of topo) {
            // Unreachable node
            if (dist[u] === INF) continue;

            // Intermediate offline nodes cannot be used
            if (u !== 0 && u !== n - 1 && !online[u]) continue;

            // Try every outgoing edge
            for (const [v, w] of graph[u]) {

                // Edge is too small for current threshold
                if (w < limit) continue;

                // Cannot move into an offline intermediate node
                if (v !== n - 1 && !online[v]) continue;

                // Relax edge
                const newCost = dist[u] + w;

                if (newCost < dist[v]) {
                    dist[v] = newCost;
                }
            }
        }

        // Valid only if total cost is within budget
        return dist[n - 1] <= k;
    };

    // No valid path even without any edge restriction
    if (!check(0)) return -1;

    // ---------------- Binary Search ----------------

    let lo = 0;
    let hi = maxCost;
    let ans = 0;

    while (lo <= hi) {
        const mid = lo + Math.floor((hi - lo) / 2);

        // If threshold works, try making it larger
        if (check(mid)) {
            ans = mid;
            lo = mid + 1;
        } else {
            // Otherwise lower the threshold
            hi = mid - 1;
        }
    }

    return ans;
}