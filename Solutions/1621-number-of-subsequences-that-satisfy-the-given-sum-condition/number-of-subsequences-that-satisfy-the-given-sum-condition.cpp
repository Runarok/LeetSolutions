class Solution {
public:
    int numSubseq(vector<int>& nums, int target) {
        const int MOD = 1e9 + 7;
        int n = nums.size();

        // Step 1: Sort the array to use two pointers efficiently
        sort(nums.begin(), nums.end());

        // Step 2: Precompute powers of 2 modulo MOD up to n
        vector<int> pow2(n, 1);
        for (int i = 1; i < n; ++i) {
            pow2[i] = (pow2[i - 1] * 2) % MOD;
        }

        int left = 0, right = n - 1;
        int result = 0;

        // Step 3: Two-pointer approach
        while (left <= right) {
            // If the smallest (nums[left]) + largest (nums[right]) is within target
            if (nums[left] + nums[right] <= target) {
                // All subsets between left and right are valid when including nums[left]
                // Number of such subsequences: 2^(right - left)
                result = (result + pow2[right - left]) % MOD;

                // Move left pointer to try next smallest element
                ++left;
            } else {
                // Otherwise, decrease the max element to reduce the sum
                --right;
            }
        }

        return result;
    }
};
