function minScore(n: number, roads: number[][]): number {
    // Adjacency list
    // graph[node] = [neighbor, distance]
    const graph: [number, number][][] = Array.from({ length: n + 1 }, () => []);

    // Build the graph
    for (const [a, b, dist] of roads) {
        graph[a].push([b, dist]);
        graph[b].push([a, dist]);
    }

    // Keeps track of visited cities
    const visited = new Array(n + 1).fill(false);

    // Answer starts very large
    let answer = Infinity;

    // Stack for iterative DFS
    const stack: number[] = [1];
    visited[1] = true;

    while (stack.length > 0) {
        const city = stack.pop()!;

        // Check every road connected to this city
        for (const [nextCity, distance] of graph[city]) {

            // Update the minimum road distance seen so far
            answer = Math.min(answer, distance);

            // Visit unvisited neighboring cities
            if (!visited[nextCity]) {
                visited[nextCity] = true;
                stack.push(nextCity);
            }
        }
    }

    return answer;
}