class Solution {
public:
    long long maxTotalValue(vector<int>& nums, int k) {
        // Find the global minimum and maximum values in the array.
        long long mn = nums[0];
        long long mx = nums[0];

        for (int x : nums) {
            mn = min(mn, (long long)x);
            mx = max(mx, (long long)x);
        }

        // Maximum value obtainable from a single subarray.
        // A subarray containing both the global min and global max
        // will have value = mx - mn.
        long long bestSingleSubarrayValue = mx - mn;

        // Since the same subarray can be chosen repeatedly,
        // choose the best one exactly k times.
        return bestSingleSubarrayValue * k;
    }
};