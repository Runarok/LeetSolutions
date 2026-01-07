class Solution {
public:
    vector<vector<int>> res; // to store all paths

    // Helper DFS function
    void dfs(vector<vector<int>>& graph, vector<int>& path, int node) {
        path.push_back(node); // add current node to the path

        int n = graph.size();
        if (node == n - 1) {
            // reached target node, save a copy of path
            res.push_back(path);
        } else {
            // explore all neighbors
            for (int next : graph[node]) {
                dfs(graph, path, next);
            }
        }

        path.pop_back(); // backtrack: remove current node before returning
    }

    vector<vector<int>> allPathsSourceTarget(vector<vector<int>>& graph) {
        vector<int> path;
        dfs(graph, path, 0); // start DFS from node 0
        return res;
    }
};
