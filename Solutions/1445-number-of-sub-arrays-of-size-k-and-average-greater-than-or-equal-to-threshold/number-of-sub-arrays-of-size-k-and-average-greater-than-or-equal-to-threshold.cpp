class Solution {
public:
    int numOfSubarrays(vector<int>& arr, int k, int threshold) {
        int n = arr.size();
        int count = 0;                  // number of valid subarrays
        int windowSum = 0;              // sum of current window
        int requiredSum = threshold * k; // sum needed to meet threshold
        
        // calculate sum of first window of size k
        for (int i = 0; i < k; i++) {
            windowSum += arr[i];
        }
        
        // check if first window meets requirement
        if (windowSum >= requiredSum) count++;
        
        // slide the window through the array
        for (int i = k; i < n; i++) {
            windowSum += arr[i];       // add new element
            windowSum -= arr[i - k];   // remove element leaving the window
            if (windowSum >= requiredSum) count++;
        }
        
        return count;
    }
};
