class Solution {
public:
    static const int MOD = 1e9 + 7;

    vector<int> depth;
    vector<vector<int>> up;
    vector<long long> pow2;
    int LOG;

    // DFS to compute depths and immediate parents
    void dfs(int node, int parent, vector<vector<int>>& adj) {
        up[node][0] = parent;

        for (int nxt : adj[node]) {
            if (nxt == parent) continue;

            depth[nxt] = depth[node] + 1;
            dfs(nxt, node, adj);
        }
    }

    // Binary Lifting LCA
    int lca(int u, int v) {
        if (depth[u] < depth[v]) swap(u, v);

        // Bring u to the same depth as v
        int diff = depth[u] - depth[v];

        for (int j = LOG - 1; j >= 0; j--) {
            if (diff & (1 << j)) {
                u = up[u][j];
            }
        }

        // Already same node
        if (u == v) return u;

        // Lift both nodes together
        for (int j = LOG - 1; j >= 0; j--) {
            if (up[u][j] != up[v][j]) {
                u = up[u][j];
                v = up[v][j];
            }
        }

        return up[u][0];
    }

    vector<int> assignEdgeWeights(vector<vector<int>>& edges,
                                  vector<vector<int>>& queries) {

        int n = edges.size() + 1;

        // Build adjacency list
        vector<vector<int>> adj(n + 1);

        for (auto &e : edges) {
            int u = e[0];
            int v = e[1];

            adj[u].push_back(v);
            adj[v].push_back(u);
        }

        // Number of levels needed for binary lifting
        LOG = 1;
        while ((1 << LOG) <= n) LOG++;

        depth.assign(n + 1, 0);
        up.assign(n + 1, vector<int>(LOG, 0));

        // Root tree at node 1
        dfs(1, 0, adj);

        // Build binary lifting table
        for (int j = 1; j < LOG; j++) {
            for (int node = 1; node <= n; node++) {
                int mid = up[node][j - 1];

                if (mid != 0)
                    up[node][j] = up[mid][j - 1];
            }
        }

        // Precompute powers of 2 modulo MOD
        pow2.assign(n + 1, 1);

        for (int i = 1; i <= n; i++) {
            pow2[i] = (pow2[i - 1] * 2) % MOD;
        }

        vector<int> answer;

        for (auto &q : queries) {
            int u = q[0];
            int v = q[1];

            int LCA = lca(u, v);

            // Number of edges on the path
            int len = depth[u] + depth[v] - 2 * depth[LCA];

            // Same node => no edges => cost always 0 (even)
            if (len == 0) {
                answer.push_back(0);
            } else {
                // Half of all assignments have odd total cost
                answer.push_back((int)pow2[len - 1]);
            }
        }

        return answer;
    }
};