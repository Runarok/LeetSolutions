class Solution {
public:
    int minScore(int n, vector<vector<int>>& roads) {
        // Step 1: Build adjacency list for the undirected graph
        vector<vector<pair<int,int>>> graph(n + 1); // node -> list of (neighbor, distance)
        for (auto &road : roads) {
            int u = road[0], v = road[1], w = road[2];
            graph[u].push_back({v, w});
            graph[v].push_back({u, w});
        }

        // Step 2: Initialize visited array and minimum score
        vector<bool> visited(n + 1, false);
        int minScore = INT_MAX;

        // Step 3: DFS stack starting from city 1
        stack<int> st;
        st.push(1);
        visited[1] = true;

        while (!st.empty()) {
            int node = st.top();
            st.pop();

            // Step 4: Explore all neighbors
            for (auto &[nei, w] : graph[node]) {
                // Update minimum score seen in this component
                minScore = min(minScore, w);

                // Visit unvisited neighbors
                if (!visited[nei]) {
                    visited[nei] = true;
                    st.push(nei);
                }
            }
        }

        // Step 5: Return the minimum edge in the component containing city 1
        return minScore;
    }
};
