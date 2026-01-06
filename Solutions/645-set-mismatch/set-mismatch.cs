public class Solution {
    public int[] FindErrorNums(int[] nums) {
        int n = nums.Length;

        // Frequency array to count occurrences of numbers 1 to n
        int[] count = new int[n + 1];

        // Count how many times each number appears
        foreach (int num in nums) {
            count[num]++;
        }

        // Variables to store the result
        int duplicate = -1;
        int missing = -1;

        // Find the duplicated and missing numbers
        for (int i = 1; i <= n; i++) {
            if (count[i] == 2) {
                // Number appears twice → duplicated
                duplicate = i;
            } else if (count[i] == 0) {
                // Number never appears → missing
                missing = i;
            }
        }

        // Return the result as [duplicate, missing]
        return new int[] { duplicate, missing };
    }
}
