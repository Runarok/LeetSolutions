class Solution {
public:
    static const int MOD = 1e9 + 7;

    // Fast exponentiation: computes (base^exp) % MOD
    long long modPow(long long base, long long exp) {
        long long result = 1;

        while (exp > 0) {
            if (exp & 1) {
                result = (result * base) % MOD;
            }

            base = (base * base) % MOD;
            exp >>= 1;
        }

        return result;
    }

    int assignEdgeWeights(vector<vector<int>>& edges) {
        int n = edges.size() + 1;

        // Build adjacency list for the tree
        vector<vector<int>> graph(n + 1);

        for (auto &e : edges) {
            int u = e[0];
            int v = e[1];

            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        // BFS from root node 1 to find maximum depth
        queue<pair<int, int>> q; // {node, depth}
        vector<int> visited(n + 1, 0);

        q.push({1, 0});
        visited[1] = 1;

        int maxDepth = 0;

        while (!q.empty()) {
            auto [node, depth] = q.front();
            q.pop();

            maxDepth = max(maxDepth, depth);

            for (int nxt : graph[node]) {
                if (!visited[nxt]) {
                    visited[nxt] = 1;
                    q.push({nxt, depth + 1});
                }
            }
        }

        /*
            Let d = maximum depth.

            The chosen deepest node x has a path of exactly d edges
            from node 1 to x.

            Each edge can be assigned either:
                1 (odd)
                2 (even)

            The total path cost is odd iff the number of edges
            assigned weight 1 is odd.

            Among all 2^d assignments, exactly half produce an odd sum,
            so the answer is:

                2^(d-1)

            (d >= 1 because n >= 2)
        */

        return (int)modPow(2, maxDepth - 1);
    }
};