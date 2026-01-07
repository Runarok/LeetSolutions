class Graph {
private:
    int n; // number of nodes in the graph
    // adjacency list: for each node, store pairs of (neighbor, edge cost)
    vector<vector<pair<int,int>>> adj;

public:
    // Constructor: initialize graph with n nodes and given edges
    Graph(int n, vector<vector<int>>& edges) {
        this->n = n;                  // store number of nodes
        adj.resize(n);                // resize adjacency list to fit n nodes

        // Add all initial edges to the adjacency list
        for (auto &e : edges) {
            int u = e[0];            // source node
            int v = e[1];            // target node
            int w = e[2];            // edge weight / cost
            adj[u].push_back({v, w}); // add directed edge u -> v with cost w
        }
    }
    
    // Add a new edge dynamically
    void addEdge(vector<int> edge) {
        int u = edge[0];              // source node of new edge
        int v = edge[1];              // target node
        int w = edge[2];              // edge cost
        adj[u].push_back({v, w});     // append to adjacency list
        // Alternative: could use a set or map if duplicate checking needed
    }
    
    // Find shortest path from node1 to node2 using Dijkstra's algorithm
    int shortestPath(int node1, int node2) {
        vector<long long> dist(n, LLONG_MAX); // distance array, initialized to "infinity"
        dist[node1] = 0;                       // distance to start node is 0

        // Min-heap priority queue: stores (distance, node)
        priority_queue<pair<long long,int>, vector<pair<long long,int>>, greater<>> pq;
        pq.push({0, node1});                   // start from node1

        while (!pq.empty()) {
            auto [d, u] = pq.top(); pq.pop(); // get node with smallest distance

            if (d > dist[u]) continue;        // skip outdated entries in the heap
            if (u == node2) return d;         // early exit if target reached

            // Explore all neighbors of u
            for (auto &[v, w] : adj[u]) {
                if (dist[v] > dist[u] + w) { // if we found shorter path to v
                    dist[v] = dist[u] + w;   // update distance
                    pq.push({dist[v], v});   // push updated distance into heap
                }
            }
        }
        
        return -1; // return -1 if node2 is unreachable
    }
};

/**
 * Example usage:
 * Graph* obj = new Graph(n, edges);     // initialize graph
 * obj->addEdge(edge);                   // add new edge
 * int ans = obj->shortestPath(a, b);   // query shortest path from a to b
 */
