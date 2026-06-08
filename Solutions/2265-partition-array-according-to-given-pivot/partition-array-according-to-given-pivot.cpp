class Solution {
public:
    vector<int> pivotArray(vector<int>& nums, int pivot) {
        
        // Stores all elements smaller than pivot
        vector<int> less;
        
        // Stores all elements equal to pivot
        vector<int> equal;
        
        // Stores all elements greater than pivot
        vector<int> greater;
        
        // Traverse the original array
        for (int num : nums) {
            
            // If current element is smaller than pivot,
            // put it into the 'less' array
            if (num < pivot) {
                less.push_back(num);
            }
            
            // If current element is greater than pivot,
            // put it into the 'greater' array
            else if (num > pivot) {
                greater.push_back(num);
            }
            
            // Otherwise it must be equal to pivot
            else {
                equal.push_back(num);
            }
        }
        
        // Result array
        vector<int> ans;
        
        // First add all smaller elements
        for (int x : less) {
            ans.push_back(x);
        }
        
        // Then add all pivot elements
        for (int x : equal) {
            ans.push_back(x);
        }
        
        // Finally add all greater elements
        for (int x : greater) {
            ans.push_back(x);
        }
        
        // Return the rearranged array
        return ans;
    }
};