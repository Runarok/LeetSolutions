class Solution {
public:
vector<int> twoSum(vector<int>& nums, int target) {
    vector<int> result(2);  // Array of size 2 to store indices
    
    // Brute force checking to find the solution
    for (int i = 0; i < nums.size(); i++) {
        for (int j = i + 1; j < nums.size(); j++) {
            if (nums[i] + nums[j] == target) {
                result[0] = i;
                result[1] = j;
                return result;
            }
        }
    }

    return {};  // If no solution is found, return an empty vector
}
};