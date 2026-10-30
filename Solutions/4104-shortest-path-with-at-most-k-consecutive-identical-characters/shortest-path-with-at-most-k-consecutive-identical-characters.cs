
public class Solution {
    public int ShortestPath(int n, int[][] edges, string labels, int k) {

        // Step 1: Build the adjacency list.
        // Each node stores its outgoing neighbors and edge weights.
        List<(int node, int weight)>[] graph =
            new List<(int node, int weight)>[n];

        for (int i = 0; i < n; i++) {
            graph[i] = new List<(int node, int weight)>();
        }

        foreach (var edge in edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];

            graph[u].Add((v, w));
        }

        // Step 2: Create the distance array.
        //
        // dist[node, count] represents the minimum cost
        // to reach 'node' with 'count' consecutive occurrences
        // of labels[node] at the end of the path.
        //
        // count ranges from 1 to k.
        int[,] dist = new int[n, k + 1];

        // Initialize all distances to infinity.
        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= k; j++) {
                dist[i, j] = int.MaxValue;
            }
        }

        // Step 3: Initialize the starting state.
        //
        // We start at node 0.
        // Its label appears once in the current path.
        dist[0, 1] = 0;

        // Priority queue stores:
        // (node, consecutiveCount)
        // Priority is the total path weight.
        var pq = new PriorityQueue<(int node, int count), int>();

        pq.Enqueue((0, 1), 0);

        // Step 4: Run Dijkstra's algorithm.
        while (pq.Count > 0) {

            // Get the state with the smallest distance.
            var current = pq.Dequeue();

            int u = current.node;
            int count = current.count;

            int currentDistance = dist[u, count];

            // Explore all outgoing edges.
            foreach (var edge in graph[u]) {

                int v = edge.node;
                int weight = edge.weight;

                int newCount;

                // If the next node has the same label,
                // increase the consecutive character count.
                if (labels[u] == labels[v]) {
                    newCount = count + 1;
                }
                else {
                    // Different character: reset the count.
                    newCount = 1;
                }

                // Reject paths that exceed the allowed limit.
                if (newCount > k) {
                    continue;
                }

                // Calculate the new total path cost.
                int newDistance = currentDistance + weight;

                // Relax the edge if we found a shorter path.
                if (newDistance < dist[v, newCount]) {

                    dist[v, newCount] = newDistance;

                    // Add the updated state to the priority queue.
                    pq.Enqueue(
                        (v, newCount),
                        newDistance
                    );
                }
            }
        }

        // Step 5: Find the minimum distance to node n - 1.
        //
        // The destination can be reached with any valid
        // consecutive character count from 1 to k.
        int answer = int.MaxValue;

        for (int count = 1; count <= k; count++) {
            answer = Math.Min(answer, dist[n - 1, count]);
        }

        // Return -1 if the destination is unreachable.
        return answer == int.MaxValue ? -1 : answer;
    }
}
