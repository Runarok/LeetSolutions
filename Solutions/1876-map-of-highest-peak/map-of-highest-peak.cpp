class Solution {
public:
    vector<vector<int>> highestPeak(vector<vector<int>>& isWater) {
        int m = isWater.size();
        int n = isWater[0].size();
        vector<vector<int>> height(m, vector<int>(n, -1)); // -1 = unvisited

        queue<pair<int,int>> q;

        // Step 1: Initialize BFS with water cells
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (isWater[i][j] == 1) {
                    height[i][j] = 0; // water height = 0
                    q.push({i, j});
                }
            }
        }

        // Directions: up, down, left, right
        vector<pair<int,int>> dirs = {{-1,0}, {1,0}, {0,-1}, {0,1}};

        // Step 2: BFS
        while (!q.empty()) {
            auto [x, y] = q.front(); q.pop();

            for (auto [dx, dy] : dirs) {
                int nx = x + dx;
                int ny = y + dy;

                // If inside grid and unvisited
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && height[nx][ny] == -1) {
                    height[nx][ny] = height[x][y] + 1; // assign height
                    q.push({nx, ny});
                }
            }
        }

        return height;
    }
};
