class Solution {
public:
    bool isPossible(int n, vector<vector<int>>& edges) {
        // Step 1: Build the graph as adjacency sets (like Python defaultdict(set))
        // graph[i] stores all nodes connected to node i
        vector<unordered_set<int>> graph(n + 1); // 1-indexed nodes

        // Step 1a: Populate the graph with existing edges
        for (auto &e : edges) {
            int u = e[0];          // endpoint u of the edge
            int v = e[1];          // endpoint v of the edge
            graph[u].insert(v);    // add v to u's neighbors
            graph[v].insert(u);    // add u to v's neighbors (undirected)
        }

        // Step 2: Find all nodes with odd degree
        vector<int> oddNodes;      // store nodes with odd number of edges
        for (int i = 1; i <= n; i++) {
            if (graph[i].size() % 2 == 1) {   // degree is odd
                oddNodes.push_back(i);        // add to list
            }
        }

        int m = oddNodes.size();    // number of odd-degree nodes

        // Step 3: Case 0 - already all nodes have even degree
        if (m == 0) return true;    // no edges need to be added

        // Step 4: Case 2 - exactly 2 odd-degree nodes
        if (m == 2) {
            int a = oddNodes[0];    // first odd node
            int b = oddNodes[1];    // second odd node

            // Step 4a: Case 2i - can we add edge directly between a and b?
            if (graph[a].count(b) == 0) return true;  // no existing edge, we can connect

            // Step 4b: Case 2ii - can we find a third node i to connect both a and b to?
            for (int i = 1; i <= n; i++) {
                if (i != a && i != b) {                       // i is not a or b
                    if (graph[i].count(a) == 0 && graph[i].count(b) == 0) {
                        // node i is not connected to a or b
                        // we can add edges (i,a) and (i,b) → degrees become even
                        return true;
                    }
                }
            }

            // Step 4c: No valid edges found → cannot fix 2 odd nodes
            return false;
        }

        // Step 5: Case 4 - exactly 4 odd-degree nodes
        if (m == 4) {
            int a = oddNodes[0];
            int b = oddNodes[1];
            int c = oddNodes[2];
            int d = oddNodes[3];

            // Step 5a: Try all 3 possible pairings of edges
            // Pairing 1: (a,b) + (c,d)
            if (graph[a].count(b) == 0 && graph[c].count(d) == 0) return true;

            // Pairing 2: (a,c) + (b,d)
            if (graph[a].count(c) == 0 && graph[b].count(d) == 0) return true;

            // Pairing 3: (a,d) + (b,c)
            if (graph[a].count(d) == 0 && graph[b].count(c) == 0) return true;

            // Step 5b: No valid pairing → cannot fix 4 odd nodes
            return false;
        }

        // Step 6: More than 4 odd nodes → impossible to fix with at most 2 edges
        return false;
    }
};
