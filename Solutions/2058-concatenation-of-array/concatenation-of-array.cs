public class Solution {
    public int[] GetConcatenation(int[] nums) {
        // Length of the input array
        int n = nums.Length;

        // Create a new array of size 2n
        int[] ans = new int[2 * n];

        // Loop through the original array
        for (int i = 0; i < n; i++) {
            // Copy element to the first half
            ans[i] = nums[i];

            // Copy element to the second half
            ans[i + n] = nums[i];
        }

        // Return the concatenated array
        return ans;
    }
}
