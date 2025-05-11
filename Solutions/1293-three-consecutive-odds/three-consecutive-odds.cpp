class Solution {
public:
    bool threeConsecutiveOdds(vector<int>& arr) {
        int n = arr.size();
        // Loop through the array up to the third-to-last element
        for (int i = 0; i < n - 2; i++) {
            // Check if the current element and the next two elements are all
            // odd
            if (arr[i] % 2 == 1 && arr[i + 1] % 2 == 1 && arr[i + 2] % 2 == 1) {
                return true;
            }
        }
        return false;
    }
};