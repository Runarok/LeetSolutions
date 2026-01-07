class Solution {
public:
    bool validPath(int n, vector<vector<int>>& edges, int source, int destination) {
        // Step 1: Build the undirected graph as adjacency list
        vector<vector<int>> graph(n); // graph[i] stores all neighbors of vertex i
        for (auto &e : edges) {
            int u = e[0], v = e[1];
            graph[u].push_back(v);   // add v to u's neighbors
            graph[v].push_back(u);   // add u to v's neighbors (undirected)
        }

        // Step 2: Keep track of visited nodes to avoid cycles
        vector<bool> visited(n, false);

        // Step 3: Define a recursive DFS function
        function<bool(int)> dfs = [&](int node) -> bool {
            if (node == destination) return true; // reached destination

            visited[node] = true; // mark current node as visited

            // Explore all neighbors
            for (int nei : graph[node]) {
                if (!visited[nei]) {
                    if (dfs(nei)) return true; // if any path reaches destination
                }
            }
            return false; // no path found from this branch
        };

        // Step 4: Start DFS from the source node
        return dfs(source);
    }
};
