class Solution {
public:
    // Parent array for Union-Find (DSU)
    vector<int> parent;

    // Find the root of x with path compression
    int find(int x) {
        if (parent[x] != x) 
            parent[x] = find(parent[x]); // Path compression
        return parent[x];
    }

    // Union two components x and y
    void unite(int x, int y) {
        parent[find(x)] = find(y); // Merge the roots
    }

    vector<bool> friendRequests(int n, vector<vector<int>>& restrictions, vector<vector<int>>& requests) {
        parent.resize(n); // Initialize parent array

        // Initially, each person is their own parent
        for (int i = 0; i < n; ++i) parent[i] = i;

        vector<bool> ans; // Store the result for each request

        // Process each friend request in order
        for (auto& req : requests) {
            int u = req[0]; // First person
            int v = req[1]; // Second person

            int ru = find(u); // Root of u
            int rv = find(v); // Root of v

            bool canMerge = true; // Flag to check if we can accept this request

            // Check all restrictions
            for (auto& r : restrictions) {
                int a = r[0]; // Restricted person a
                int b = r[1]; // Restricted person b

                int ra = find(a); // Root of a
                int rb = find(b); // Root of b

                // If merging u and v would connect restricted pair, deny
                if ((ru == ra && rv == rb) || (ru == rb && rv == ra)) {
                    canMerge = false; // Cannot merge due to restriction
                    break; // No need to check further restrictions
                }
            }

            if (canMerge) {
                unite(ru, rv); // Merge the components since no restriction is violated
                ans.push_back(true); // Request successful
            } else {
                ans.push_back(false); // Request denied
            }
        }

        return ans; // Return the results
    }
};
