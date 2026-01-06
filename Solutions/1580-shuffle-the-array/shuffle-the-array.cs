public class Solution {
    public int[] Shuffle(int[] nums, int n) {
        // Create a result array of the same length
        int[] result = new int[2 * n];

        // Pointer for the first half (x1, x2, ..., xn)
        int left = 0;

        // Pointer for the second half (y1, y2, ..., yn)
        int right = n;

        // Index for the result array
        int index = 0;

        // Loop until we process all n pairs
        while (left < n) {
            // Add x element
            result[index++] = nums[left++];

            // Add y element
            result[index++] = nums[right++];
        }

        // Return the shuffled array
        return result;
    }
}
