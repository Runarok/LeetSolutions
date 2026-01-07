class Solution {
public:
    // DSU helper functions
    int find(int x, vector<int>& parent) {
        if (parent[x] != x) parent[x] = find(parent[x], parent);
        return parent[x];
    }

    void unite(int x, int y, vector<int>& parent) {
        int px = find(x, parent);
        int py = find(y, parent);
        if (px != py) parent[px] = py;
    }

    int largestComponentSize(vector<int>& nums) {
        int n = nums.size();
        vector<int> parent(100001);
        for (int i = 0; i <= 100000; ++i) parent[i] = i;

        unordered_map<int, int> factorToIndex; // maps factor -> first index using it

        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            for (int f = 2; f * f <= num; ++f) {
                if (num % f == 0) {
                    // f is a factor
                    if (!factorToIndex.count(f)) factorToIndex[f] = i;
                    else unite(i, factorToIndex[f], parent);
                    
                    // num / f is also a factor
                    int other = num / f;
                    if (other != f) { // avoid square factor
                        if (!factorToIndex.count(other)) factorToIndex[other] = i;
                        else unite(i, factorToIndex[other], parent);
                    }
                }
            }
            // if num itself > 1 and prime
            if (num > 1) {
                if (!factorToIndex.count(num)) factorToIndex[num] = i;
                else unite(i, factorToIndex[num], parent);
            }
        }

        unordered_map<int, int> count;
        int res = 0;
        for (int i = 0; i < n; ++i) {
            int root = find(i, parent);
            count[root]++;
            res = max(res, count[root]);
        }
        return res;
    }
};
