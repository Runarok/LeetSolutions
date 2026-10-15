public class Solution {
    public int SumCounts(IList<int> nums) {

        // Stores the sum of squared distinct counts
        // for all possible subarrays.
        int totalSum = 0;

        // Get the total number of elements in the array.
        int n = nums.Count;

        // Choose the starting index of the subarray.
        for (int i = 0; i < n; i++) {

            // A HashSet stores only unique values.
            // It helps us count distinct elements easily.
            HashSet<int> distinct = new HashSet<int>();

            // Choose the ending index of the subarray.
            // Start from i so every subarray is non-empty.
            for (int j = i; j < n; j++) {

                // Add the current element to the set.
                // If the element already exists, the set
                // will not add a duplicate.
                distinct.Add(nums[j]);

                // The number of elements in the set
                // equals the number of distinct values
                // in the current subarray nums[i..j].
                int distinctCount = distinct.Count;

                // Square the distinct count and add it
                // to the answer.
                totalSum += distinctCount * distinctCount;
            }
        }

        // Return the sum for all possible subarrays.
        return totalSum;
    }
}