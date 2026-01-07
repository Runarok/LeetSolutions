class Solution {
public:
    bool canVisitAllRooms(vector<vector<int>>& rooms) {
        int n = rooms.size();
        
        vector<bool> visited(n, false); // track which rooms we've visited
        queue<int> q;                   // queue for BFS
        
        // Start with room 0
        visited[0] = true;
        q.push(0);
        
        while (!q.empty()) {
            int room = q.front();
            q.pop();
            
            // Visit all keys found in the current room
            for (int key : rooms[room]) {
                if (!visited[key]) {
                    visited[key] = true; // mark room as visited
                    q.push(key);         // add room to queue to explore its keys
                }
            }
        }
        
        // Check if all rooms were visited
        for (bool v : visited) {
            if (!v) return false; // found a room that is not reachable
        }
        
        return true; // all rooms visited
    }
};
