public class Solution {
    public long MaxAlternatingSum(int[] nums) {

        // Step 1: Get the total number of elements in the array.
        int n = nums.Length;

        // Step 2: Square every element.
        // The alternating score uses nums[i] * nums[i],
        // so the original signs (+ or -) do not matter.
        //
        // For example:
        //  1  -> 1
        // -1  -> 1
        //  2  -> 4
        // -2  -> 4
        //  3  -> 9
        // -3  -> 9
        //
        // IMPORTANT:
        // We cast to long before multiplying to avoid overflow
        // if the constraints are larger in a different problem.
        long[] squares = new long[n];

        for (int i = 0; i < n; i++) {
            squares[i] = (long)nums[i] * nums[i];
        }

        // Step 3: Sort the squared values in ascending order.
        // The smallest squares will be at the beginning,
        // and the largest squares will be at the end.
        Array.Sort(squares);

        // Step 4: Initialize the answer.
        // Use long because the total sum of squares can exceed int.
        long ans = 0;

        // Step 5: Subtract the smallest n / 2 squared values.
        // These values should occupy the negative positions
        // in the alternating expression.
        //
        // Example:
        // If squares = [1, 1, 4, 4, 9, 9],
        // subtract 1 and 1 and 4.
        for (int i = 0; i < n / 2; i++) {
            ans -= squares[i];
        }

        // Step 6: Add the remaining larger squared values.
        // These values should occupy the positive positions.
        //
        // For [1, 1, 4, 4, 9, 9]:
        // Add 4, 9, and 9.
        //
        // Result = -1 - 1 - 4 + 4 + 9 + 9 = 16.
        for (int i = n / 2; i < n; i++) {
            ans += squares[i];
        }

        // Step 7: Return the maximum possible alternating score.
        return ans;
    }
}