class Solution {
public:
    vector<vector<int>> res; // store all valid paths from 0 to n-1

    // Helper DFS function
    // graph: adjacency list of DAG
    // path: current path being explored
    // node: current node in DFS
    void dfs(vector<vector<int>>& graph, vector<int>& path, int node) {
        path.push_back(node); // add current node to the path

        int n = graph.size(); // total number of nodes

        if (node == n - 1) {
            // Base case: reached target node (n-1)
            // Save a copy of the current path
            res.push_back(path);
        } else {
            // Recursive case: explore all neighbors of the current node
            for (int next : graph[node]) {
                dfs(graph, path, next); // explore neighbor
            }
        }

        path.pop_back(); // Backtracking: remove current node before returning
    }

    // Main function
    vector<vector<int>> allPathsSourceTarget(vector<vector<int>>& graph) {
        vector<int> path;       // store the current path during DFS
        dfs(graph, path, 0);    // start DFS from node 0
        return res;             // return all collected paths
    }
};
