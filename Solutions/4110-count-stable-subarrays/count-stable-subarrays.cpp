class Solution {
public:
    #define ll long long                     // Alias for long long for convenience
    #define debug(x) cout<<#x<<" is: "<<x<<endl;  // Debug macro to print variable name and value

    // Function to count stable (non-decreasing) subarrays for each query
    vector<long long> countStableSubarrays(vector<int>& nums, vector<vector<int>>& queries) {
        ll n = nums.size();                    // Size of the input array
        vector<ll> ans;                        // Vector to store answers for each query

        int last = nums[0];                    // Track last value to detect non-decreasing segments
        nums[0] = 1;                           // Dummy transformation (not strictly necessary)

        // -------- Step 1: Build blocks of non-decreasing segments --------
        vector<ll> block;                      // Stores total count of subarrays in each block
        vector<pair<ll,ll>> dj;                // Stores the start and end indices of each block
        unordered_map<ll,ll> mp;               // Maps original index -> block number

        ll bl = 0;                             // Current block number
        mp[0] = bl;                             // First element belongs to block 0
        ll len = 1;                             // Length of current block (start with first element)

        for(int i = 1; i < n; i++) {
            if(nums[i] >= last) {              // Still non-decreasing
                last = nums[i];                // Update last value
                mp[i] = bl;                     // Current index belongs to current block
                len++;                          // Increase current block length
            } else {                            // Start of a new block
                block.push_back(len * (len + 1) / 2); // Total number of subarrays in this block
                dj.push_back({i - 1 - len + 1, i - 1}); // Store start and end indices of this block
                len = 1;                        // Reset length for new block
                last = nums[i];                 // Update last value
                bl++;                            // Move to next block number
                mp[i] = bl;                      // Current index belongs to new block
            }
        }

        // Push the last block after finishing the loop
        block.push_back(len * (len + 1) / 2);
        dj.push_back({n - 1 - len + 1, n - 1});

        ll sz = block.size();                   // Total number of blocks

        // -------- Step 2: Prefix sum of block values --------
        // This helps quickly sum subarrays from full blocks between queries
        vector<ll> pref(sz);                    // Prefix sum of block subarray counts
        pref[0] = block[0];                     // First block
        for(int i = 1; i < sz; i++) {
            pref[i] = pref[i - 1] + block[i];  // Prefix sum
        }

        // -------- Step 3: Process each query --------
        for(auto& x: queries) {
            ll l = x[0], r = x[1];             // Query indices [l, r]
            ll lb = mp[l], rb = mp[r];         // Find which block l and r belong to

            if(lb == rb) {                      // Case 1: l and r are in the same block
                ll len = r - l + 1;            // Length of subarray inside block
                ans.push_back(len * (len + 1) / 2); // All subarrays inside block are stable
                continue;                        // Done with this query
            }

            ll sm = 0;                          // Sum of stable subarrays for this query

            // Case 2: Full blocks between lb and rb (if any)
            if(abs(lb - rb) >= 2) {             // If there are blocks completely inside query range
                sm = pref[rb - 1] - pref[lb];  // Sum of full blocks between left and right block
            }

            // Case 3: Partial left block (from l to end of left block)
            auto& xx = dj[lb];                  // Get start and end of left block
            ll len = xx.second - l + 1;         // Length of partial block
            sm += len * (len + 1) / 2;          // Add subarrays in partial left block

            // Case 4: Partial right block (from start of right block to r)
            auto& y = dj[rb];                   // Get start and end of right block
            len = r - y.first + 1;              // Length of partial block
            sm += len * (len + 1) / 2;          // Add subarrays in partial right block

            ans.push_back(sm);                  // Store answer for this query
        }

        return ans;                             // Return answers for all queries
    }
};
