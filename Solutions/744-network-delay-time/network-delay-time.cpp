class Solution {
public:
    int networkDelayTime(vector<vector<int>>& times, int n, int k) {
        // Step 1: Build the graph (adjacency list)
        vector<vector<pair<int,int>>> graph(n + 1); // node -> [(neighbor, weight)]
        for (auto &t : times) {
            int u = t[0], v = t[1], w = t[2];
            graph[u].push_back({v, w});
        }

        // Step 2: Initialize distances
        vector<int> dist(n + 1, INT_MAX);
        dist[k] = 0; // distance to source is 0

        // Step 3: Min-heap priority queue for Dijkstra {distance, node}
        priority_queue<pair<int,int>, vector<pair<int,int>>, greater<pair<int,int>>> pq;
        pq.push({0, k});

        while (!pq.empty()) {
            auto [d, u] = pq.top(); pq.pop();

            // If we already found a shorter path, skip
            if (d > dist[u]) continue;

            // Step 4: Relax edges
            for (auto &[v, w] : graph[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.push({dist[v], v});
                }
            }
        }

        // Step 5: Find the maximum distance
        int ans = 0;
        for (int i = 1; i <= n; i++) {
            if (dist[i] == INT_MAX) return -1; // unreachable node
            ans = max(ans, dist[i]);
        }

        return ans;
    }
};
