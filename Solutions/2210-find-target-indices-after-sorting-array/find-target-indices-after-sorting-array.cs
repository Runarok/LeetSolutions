using System;
using System.Collections.Generic;

public class Solution {
    public IList<int> TargetIndices(int[] nums, int target) {
        // Sort the array in non-decreasing order
        Array.Sort(nums);
        
        List<int> result = new List<int>();
        
        // Find all indices where nums[i] == target
        for (int i = 0; i < nums.Length; i++) {
            if (nums[i] == target) {
                result.Add(i);
            }
        }
        
        return result;
    }
}