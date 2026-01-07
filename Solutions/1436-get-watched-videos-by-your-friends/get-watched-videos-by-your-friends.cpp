class Solution {
public:
    vector<string> watchedVideosByFriends(vector<vector<string>>& watchedVideos, vector<vector<int>>& friends, int id, int level) {
        int n = friends.size();
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(id);
        visited[id] = true;

        int currentLevel = 0;

        // Step 1: BFS to find all people at the exact level
        while (!q.empty() && currentLevel < level) {
            int sz = q.size();
            for (int i = 0; i < sz; ++i) {
                int person = q.front(); q.pop();
                for (int f : friends[person]) {
                    if (!visited[f]) {
                        visited[f] = true;
                        q.push(f);
                    }
                }
            }
            currentLevel++;
        }

        // Step 2: Collect all videos from people at the desired level
        unordered_map<string,int> freq;
        while (!q.empty()) {
            int person = q.front(); q.pop();
            for (string &vid : watchedVideos[person]) {
                freq[vid]++;
            }
        }

        // Step 3: Transfer to a vector for sorting
        vector<pair<string,int>> videos;
        for (auto &[vid,cnt] : freq) {
            videos.push_back({vid, cnt});
        }

        // Step 4: Sort by frequency ascending, then lexicographically
        sort(videos.begin(), videos.end(), [](const pair<string,int>& a, const pair<string,int>& b){
            if (a.second != b.second) return a.second < b.second;
            return a.first < b.first;
        });

        // Step 5: Extract the sorted video names
        vector<string> result;
        for (auto &[vid, _] : videos) result.push_back(vid);

        return result;
    }
};
