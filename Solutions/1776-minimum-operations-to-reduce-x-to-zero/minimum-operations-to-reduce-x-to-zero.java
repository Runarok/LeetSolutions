class Solution {
    public int minOperations(int[] nums, int x) {
        int totalSum = 0;
        
        // Step 1: Calculate the total sum of all elements in the array
        for (int num : nums) {
            totalSum += num;
        }
        
        // Step 2: Define the target sum for the middle contiguous subarray
        int target = totalSum - x;
        
        // If the sum of all elements is exactly x, we must remove all elements
        if (target == 0) {
            return nums.length;
        }
        
        // If target is negative, total sum is less than x, so it's impossible
        if (target < 0) {
            return -1;
        }
        
        // Step 3: Use a sliding window to find the longest subarray with sum equal to target
        int currentSum = 0;
        int maxLength = -1;
        int left = 0;
        
        for (int right = 0; right < nums.length; right++) {
            // Expand the window by adding the element at the right pointer
            currentSum += nums[right];
            
            // Shrink the window from the left if the current sum exceeds target
            while (currentSum > target && left <= right) {
                currentSum -= nums[left];
                left++;
            }
            
            // Check if we found a valid subarray matching the target sum
            if (currentSum == target) {
                maxLength = Math.max(maxLength, right - left + 1);
            }
        }
        
        // Step 4: If no valid window was found, return -1; otherwise return total elements - max window size
        return maxLength == -1 ? -1 : nums.length - maxLength;
    }
}