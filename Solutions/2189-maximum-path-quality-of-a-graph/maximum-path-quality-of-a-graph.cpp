class Solution {
public:
    int maximalPathQuality(vector<int>& values, vector<vector<int>>& edges, int maxTime) {
        int n = values.size();
        
        // Build adjacency list: graph[node] = list of {neighbor, travel_time}
        vector<vector<pair<int,int>>> graph(n);
        for(auto &e : edges) {
            int u = e[0], v = e[1], t = e[2];
            graph[u].push_back({v,t});
            graph[v].push_back({u,t}); // because the graph is undirected
        }

        int maxQuality = 0; // store the maximum path quality found
        vector<int> visited(n,0); // keep track of how many times each node is visited
        visited[0] = 1; // we start at node 0, so it's "visited" once
        int currentQuality = values[0]; // initial quality includes node 0

        // DFS function: explore all paths
        function<void(int,int,int)> dfs = [&](int node, int timeSpent, int quality) {
            // Ton comment: every time we return to node 0, we can consider updating maxQuality
            if(node == 0) maxQuality = max(maxQuality, quality);

            for(auto &[next, t] : graph[node]) { // iterate over neighbors
                if(timeSpent + t > maxTime) continue; // skip if it exceeds maxTime

                bool firstVisit = visited[next] == 0; // check if this node is visited for the first time
                if(firstVisit) quality += values[next]; // add value of node if first time
                visited[next]++; // mark as visited (increment, because we can visit multiple times)

                dfs(next, timeSpent + t, quality); // recursive DFS call

                visited[next]--; // backtrack: unmark visit
                if(firstVisit) quality -= values[next]; // remove node value if it was first visit
            }
        };

        dfs(0, 0, currentQuality); // start DFS from node 0, time spent = 0
        return maxQuality; // finally, return the maximum path quality
    }
};
