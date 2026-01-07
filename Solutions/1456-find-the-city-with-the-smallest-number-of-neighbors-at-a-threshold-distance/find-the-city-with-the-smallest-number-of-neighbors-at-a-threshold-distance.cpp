class Solution {
public:
    int findTheCity(int n, vector<vector<int>>& edges, int distanceThreshold) {
        // Step 1: Initialize distance matrix
        vector<vector<int>> dist(n, vector<int>(n, 1e9)); // Use large number as INF
        
        // Distance from a city to itself is 0
        for (int i = 0; i < n; i++) dist[i][i] = 0;
        
        // Fill in the given edges (bidirectional)
        for (auto &e : edges) {
            int u = e[0], v = e[1], w = e[2];
            dist[u][v] = w;
            dist[v][u] = w;  // because edges are bidirectional
        }
        
        // Step 2: Floyd-Warshall algorithm to compute all-pairs shortest paths
        for (int k = 0; k < n; k++) {        // intermediate node
            for (int i = 0; i < n; i++) {    // source node
                for (int j = 0; j < n; j++) {// destination node
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j]; // update shortest path
                    }
                }
            }
        }
        
        // Step 3: Count reachable cities within distanceThreshold for each city
        int resCity = -1;       // the answer city
        int minReachable = n+1; // initialize with max possible value
        
        for (int i = 0; i < n; i++) {
            int reachable = 0; // count cities reachable from city i
            for (int j = 0; j < n; j++) {
                if (i != j && dist[i][j] <= distanceThreshold) {
                    reachable++;
                }
            }
            
            // Step 4: Update result based on problem rule
            // If smaller count or equal count but larger city number
            if (reachable < minReachable || (reachable == minReachable && i > resCity)) {
                minReachable = reachable;
                resCity = i;
            }
        }
        
        return resCity;
    }
};
