class Solution {
    public int[] twoSum(int[] nums, int target) {
        int[] result = new int[2];  // Array of size 2 to store indices
        
        // Brute force checking to find the solution
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (nums[i] + nums[j] == target) {
                    result[0] = i;
                    result[1] = j;
                    return result;
                }
            }
        }

        return null;  // If no solution is found, return null
    }
}