class Solution {
public:
    // Dijkstra's algorithm
    vector<long long> dijkstra(int n, vector<vector<pair<int,int>>>& graph, int start) {
        vector<long long> dist(n, LLONG_MAX);
        dist[start] = 0;
        priority_queue<pair<long long,int>, vector<pair<long long,int>>, greater<>> pq;
        pq.push({0, start});
        
        while (!pq.empty()) {
            auto [d, u] = pq.top(); pq.pop();
            if (d > dist[u]) continue;
            
            for (auto &[v, w] : graph[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.push({dist[v], v});
                }
            }
        }
        return dist;
    }
    
    long long minimumWeight(int n, vector<vector<int>>& edges, int src1, int src2, int dest) {
        vector<vector<pair<int,int>>> graph(n), revGraph(n);
        
        // Build original and reversed graphs
        for (auto &e : edges) {
            int u = e[0], v = e[1], w = e[2];
            graph[u].push_back({v, w});
            revGraph[v].push_back({u, w}); // reverse edge
        }
        
        // Step 1: shortest paths from src1, src2
        vector<long long> distSrc1 = dijkstra(n, graph, src1);
        vector<long long> distSrc2 = dijkstra(n, graph, src2);
        
        // Step 2: shortest paths to dest using reversed graph
        vector<long long> distToDest = dijkstra(n, revGraph, dest);
        
        // Step 3: find minimum total weight
        long long ans = LLONG_MAX;
        for (int i = 0; i < n; ++i) {
            if (distSrc1[i] == LLONG_MAX || distSrc2[i] == LLONG_MAX || distToDest[i] == LLONG_MAX) 
                continue; // node i unreachable from some source or can't reach dest
            ans = min(ans, distSrc1[i] + distSrc2[i] + distToDest[i]);
        }
        
        return ans == LLONG_MAX ? -1 : ans;
    }
};
