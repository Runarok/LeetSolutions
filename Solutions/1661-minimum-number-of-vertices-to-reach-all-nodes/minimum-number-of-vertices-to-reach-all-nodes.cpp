class Solution {
public:
    vector<int> findSmallestSetOfVertices(int n, vector<vector<int>>& edges) {
        vector<int> in_degree(n, 0);
        
        // Count in-degree for each node
        for (auto& edge : edges) {
            int to = edge[1];
            in_degree[to]++;
        }
        
        vector<int> result;
        // Nodes with in-degree 0 are part of the answer
        for (int i = 0; i < n; i++) {
            if (in_degree[i] == 0) {
                result.push_back(i);
            }
        }
        
        return result;
    }
};
