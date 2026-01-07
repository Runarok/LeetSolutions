class Solution {
public:
    vector<int> shortestAlternatingPaths(int n, vector<vector<int>>& redEdges, vector<vector<int>>& blueEdges) {
        // Step 1: Build adjacency lists for red and blue edges
        vector<vector<int>> redGraph(n), blueGraph(n);
        for (auto &e : redEdges) redGraph[e[0]].push_back(e[1]);
        for (auto &e : blueEdges) blueGraph[e[0]].push_back(e[1]);

        // Step 2: Result array, -1 means unreachable
        vector<int> answer(n, -1);

        // Step 3: Visited array, two colors: 0=red,1=blue
        vector<vector<bool>> visited(n, vector<bool>(2,false));

        // Step 4: BFS queue: {node, distance, lastEdgeColor (0=red,1=blue)}
        queue<tuple<int,int,int>> q;
        q.push({0,0,-1}); // start from node 0, distance 0, no last color
        visited[0][0] = visited[0][1] = true; // starting node marked visited for both

        while (!q.empty()) {
            auto [node, dist, color] = q.front(); q.pop();

            // Set answer if first time reaching node
            if (answer[node] == -1) answer[node] = dist;

            // Step 5: Explore neighbors
            if (color != 0) { // last edge not red, can take red edges
                for (int nei : redGraph[node]) {
                    if (!visited[nei][0]) {
                        visited[nei][0] = true;
                        q.push({nei, dist+1, 0});
                    }
                }
            }
            if (color != 1) { // last edge not blue, can take blue edges
                for (int nei : blueGraph[node]) {
                    if (!visited[nei][1]) {
                        visited[nei][1] = true;
                        q.push({nei, dist+1, 1});
                    }
                }
            }
        }

        return answer;
    }
};
