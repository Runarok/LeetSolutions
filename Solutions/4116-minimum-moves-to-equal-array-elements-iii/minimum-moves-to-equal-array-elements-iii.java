public class Solution {
    public int minMoves(int[] nums) {
        // 1. Identify the target baseline that all elements must uniformly reach
        int maxNum = nums[0];
        for (int num : nums) {
            if (num > maxNum) maxNum = num;
        }
        // Define the exact adjustment distance required for a single value
        // 2. Map current states into a lazy sequence of individual adjustments
        // 3. Accumulate all individual adjustments to determine global cost
        int totMoves = 0;
        for (int num : nums) {
            totMoves += maxNum - num;
        }

        return totMoves;
    }
}