public class Solution {
    public int FindMaxConsecutiveOnes(int[] nums) {
        // Stores the maximum number of consecutive 1s found
        int maxCount = 0;

        // Stores the current number of consecutive 1s
        int currentCount = 0;

        // Loop through each number in the array
        for (int i = 0; i < nums.Length; i++) {
            if (nums[i] == 1) {
                // If the current number is 1, increase the streak
                currentCount++;

                // Update maxCount if the current streak is larger
                maxCount = Math.Max(maxCount, currentCount);
            } else {
                // If the current number is 0, reset the streak
                currentCount = 0;
            }
        }

        // Return the maximum consecutive 1s
        return maxCount;
    }
}
