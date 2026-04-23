import java.util.*;

class Solution {
    public long[] distance(int[] nums) {
        int n = nums.length;
        
        // Result array
        long[] result = new long[n];
        
        // Step 1: Group indices by value
        // Map: value -> list of indices where it appears
        Map<Integer, List<Integer>> map = new HashMap<>();
        
        for (int i = 0; i < n; i++) {
            map.computeIfAbsent(nums[i], k -> new ArrayList<>()).add(i);
        }
        
        // Step 2: Process each group independently
        for (List<Integer> list : map.values()) {
            
            int size = list.size();
            
            // If only one occurrence, distance is 0
            if (size == 1) continue;
            
            // Prefix sum array
            // prefix[i] = sum of first i elements in list
            long[] prefix = new long[size + 1];
            
            for (int i = 0; i < size; i++) {
                prefix[i + 1] = prefix[i] + list.get(i);
            }
            
            // Step 3: Compute result for each index in this group
            for (int i = 0; i < size; i++) {
                int index = list.get(i); // actual index in nums
                
                // Number of elements on left = i
                // Number of elements on right = size - i - 1
                
                // Sum of left indices
                long leftSum = prefix[i];
                
                // Sum of right indices
                long rightSum = prefix[size] - prefix[i + 1];
                
                // Left contribution:
                // distance to all left indices
                long leftContribution = (long)i * index - leftSum;
                
                // Right contribution:
                // distance to all right indices
                long rightContribution = rightSum - (long)(size - i - 1) * index;
                
                // Total distance
                result[index] = leftContribution + rightContribution;
            }
        }
        
        return result;
    }
}