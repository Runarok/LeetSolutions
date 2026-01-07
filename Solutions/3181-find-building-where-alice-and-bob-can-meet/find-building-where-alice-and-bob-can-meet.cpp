class Solution {
public:
    vector<int> leftmostBuildingQueries(vector<int>& heights, vector<vector<int>>& queries) {
        
        int n = heights.size();
        int q = queries.size();
        
        // Result array, initialized with -1
        vector<int> ans(q, -1);
        
        // Store queries as: {rightIndex, maxHeightNeeded, queryIndex}
        vector<vector<int>> deferred;
        
        // -----------------------------------------
        // STEP 1: Handle easy cases & prepare queries
        // -----------------------------------------
        for (int i = 0; i < q; i++) {
            int a = queries[i][0];
            int b = queries[i][1];
            
            // Same building
            if (a == b) {
                ans[i] = a;
                continue;
            }
            
            int left = min(a, b);
            int right = max(a, b);
            
            // Directly meet at right
            if (heights[left] < heights[right]) {
                ans[i] = right;
            } 
            else {
                // Need a building taller than BOTH
                deferred.push_back({
                    right,
                    max(heights[left], heights[right]),
                    i
                });
            }
        }
        
        // Sort deferred queries by right index
        sort(deferred.begin(), deferred.end());
        
        // -----------------------------------------
        // STEP 2: Traverse buildings & resolve queries
        // -----------------------------------------
        
        // Min-heap based on required height
        priority_queue<pair<int,int>, vector<pair<int,int>>, greater<>> pq;
        
        int idx = 0; // pointer to deferred queries
        
        for (int i = 0; i < n; i++) {
            
            // Add queries whose right == i
            while (idx < deferred.size() && deferred[idx][0] == i) {
                pq.push({deferred[idx][1], deferred[idx][2]});
                idx++;
            }
            
            // Resolve queries that can be satisfied by current building
            while (!pq.empty() && heights[i] > pq.top().first) {
                ans[pq.top().second] = i;
                pq.pop();
            }
        }
        
        return ans;
    }
};
