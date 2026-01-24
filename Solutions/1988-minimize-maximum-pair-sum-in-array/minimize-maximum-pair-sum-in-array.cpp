class Solution {
public:
    int minPairSum(vector<int>& nums) {
        // Sort the array so we can pair smallest with largest
        sort(nums.begin(), nums.end());
        
        int left = 0;                  // Pointer to smallest element
        int right = nums.size() - 1;   // Pointer to largest element
        int maxPairSum = 0;            // Store the maximum pair sum
        
        // Pair elements until all are used
        while (left < right) {
            // Current pair sum
            int currentSum = nums[left] + nums[right];
            
            // Update the maximum pair sum seen so far
            maxPairSum = max(maxPairSum, currentSum);
            
            // Move inward to next smallest and next largest
            left++;
            right--;
        }
        
        return maxPairSum;
    }
};
