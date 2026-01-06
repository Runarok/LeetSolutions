public class Solution {
    public int[] SmallerNumbersThanCurrent(int[] nums) {
        // Frequency array for numbers from 0 to 100
        int[] count = new int[101];

        // Step 1: Count occurrences of each number
        foreach (int num in nums) {
            count[num]++;
        }

        // Step 2: Build prefix sums
        // count[i] will store how many numbers are < i
        for (int i = 1; i <= 100; i++) {
            count[i] += count[i - 1];
        }

        // Result array
        int[] result = new int[nums.Length];

        // Step 3: For each number, find how many are smaller
        for (int i = 0; i < nums.Length; i++) {
            if (nums[i] == 0) {
                // No number is smaller than 0
                result[i] = 0;
            } else {
                // Numbers smaller than nums[i]
                result[i] = count[nums[i] - 1];
            }
        }

        // Return the final result
        return result;
    }
}
