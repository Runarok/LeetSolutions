/**
 * @param {number} n
 * @param {number[][]} roads
 * @return {number}
 */
var countPaths = function(n, roads) {
    const MOD = 1_000_000_007;

    // Step 1: Build adjacency list
    const graph = Array.from({ length: n }, () => []);
    for (let [start_node, end_node, travel_time] of roads) {
        graph[start_node].push([end_node, travel_time]);
        graph[end_node].push([start_node, travel_time]);
    }

    // Step 2: Min-Heap (priority queue) for Dijkstra's algorithm
    const minHeap = [[0, 0]];  // (time, node)
    const shortestTime = new Array(n).fill(Infinity);
    const pathCount = new Array(n).fill(0);

    shortestTime[0] = 0;  // Distance to source is 0
    pathCount[0] = 1;     // 1 way to reach node 0

    while (minHeap.length > 0) {
        const [currTime, currNode] = minHeap.shift(); // Pop the node with the smallest distance

        // Skip outdated distances
        if (currTime > shortestTime[currNode]) {
            continue;
        }

        // Explore neighbors
        for (let [neighborNode, roadTime] of graph[currNode]) {
            const newTime = currTime + roadTime;
            // Found a new shortest path → Update shortest time and reset path count
            if (newTime < shortestTime[neighborNode]) {
                shortestTime[neighborNode] = newTime;
                pathCount[neighborNode] = pathCount[currNode];
                minHeap.push([newTime, neighborNode]);
            }
            // Found another way with the same shortest time → Add to path count
            else if (newTime === shortestTime[neighborNode]) {
                pathCount[neighborNode] = (pathCount[neighborNode] + pathCount[currNode]) % MOD;
            }
        }

        // Sort the minHeap to maintain the priority queue behavior after updates
        minHeap.sort((a, b) => a[0] - b[0]);
    }

    return pathCount[n - 1];
};
