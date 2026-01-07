class Solution {
public:
    int countCompleteComponents(int n, vector<vector<int>>& edges) {
        // Step 1: Build adjacency list
        vector<vector<int>> graph(n);
        for (auto &e : edges) {
            int u = e[0], v = e[1];
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        vector<bool> visited(n, false);
        int completeCount = 0;

        // Step 2: Explore all components
        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                vector<int> component;
                int edgeCount = 0;

                // DFS to collect component nodes
                stack<int> st;
                st.push(i);
                visited[i] = true;

                while (!st.empty()) {
                    int node = st.top();
                    st.pop();
                    component.push_back(node);

                    for (int nei : graph[node]) {
                        edgeCount++; // count all edges in component
                        if (!visited[nei]) {
                            visited[nei] = true;
                            st.push(nei);
                        }
                    }
                }

                // Each edge was counted twice in undirected graph
                edgeCount /= 2;

                int k = component.size();
                // Step 3: Check if complete
                if (edgeCount == k * (k - 1) / 2) {
                    completeCount++;
                }
            }
        }

        return completeCount;
    }
};
