using System;

public class Solution
{
    public int[] LexicographicallySmallestArray(int[] nums, int limit)
    {
        int n = nums.Length;

        /*
         * We need to remember:
         *
         * 1. The value
         * 2. Its original index
         *
         * So each pair will look like:
         *
         * [value, originalIndex]
         *
         * Example:
         *
         * nums = [1, 5, 3, 9, 8]
         *
         * pairs:
         * [1, 0]
         * [5, 1]
         * [3, 2]
         * [9, 3]
         * [8, 4]
         */
        int[][] pairs = new int[n][];

        for (int i = 0; i < n; i++)
        {
            pairs[i] = new int[] { nums[i], i };
        }

        /*
         * Sort the pairs by value.
         *
         * Before:
         * [1,0] [5,1] [3,2] [9,3] [8,4]
         *
         * After:
         * [1,0] [3,2] [5,1] [8,4] [9,3]
         *
         * We need the values sorted because this allows us
         * to easily find groups of values that can be swapped.
         */
        Array.Sort(pairs, (a, b) =>
        {
            return a[0].CompareTo(b[0]);
        });

        /*
         * We process one connected group at a time.
         *
         * Example:
         *
         * Sorted values:
         *
         * 1  3  5  8  9
         *
         * limit = 2
         *
         * 1 -> 3 : difference = 2  => same group
         * 3 -> 5 : difference = 2  => same group
         * 5 -> 8 : difference = 3  => different group
         * 8 -> 9 : difference = 1  => same group
         *
         * Therefore:
         *
         * Group 1 = [1, 3, 5]
         * Group 2 = [8, 9]
         */
        int start = 0;

        while (start < n)
        {
            int end = start;

            /*
             * Find the end of the current group.
             *
             * We only need to check consecutive values.
             *
             * Why?
             *
             * Suppose:
             *
             * 1, 3, 5
             *
             * limit = 2
             *
             * 1 and 5 cannot be directly swapped because
             * their difference is 4.
             *
             * BUT:
             *
             * 1 <-> 3
             * 3 <-> 5
             *
             * means 1 and 5 can still reach each other.
             *
             * So a group is formed whenever consecutive
             * sorted values differ by <= limit.
             */
            while (end + 1 < n &&
                   (long)pairs[end + 1][0] - pairs[end][0] <= limit)
            {
                end++;
            }

            /*
             * We now have one complete group:
             *
             * pairs[start ... end]
             *
             * The values are already sorted because we sorted
             * the entire pairs array earlier.
             *
             * We need to find the original indices of these values.
             */
            int size = end - start + 1;

            int[] indices = new int[size];

            for (int i = 0; i < size; i++)
            {
                indices[i] = pairs[start + i][1];
            }

            /*
             * Sort the original indices.
             *
             * Example:
             *
             * Values in this group:
             * [1, 3, 5]
             *
             * Their original indices:
             * [2, 1, 0]
             *
             * After sorting:
             * [0, 1, 2]
             *
             * Since we want the lexicographically smallest array,
             * the smallest value should go to the smallest index.
             *
             * Therefore:
             *
             * index 0 -> 1
             * index 1 -> 3
             * index 2 -> 5
             */
            Array.Sort(indices);

            /*
             * Assign the sorted values to the sorted indices.
             *
             * pairs[start + i][0] is the i-th smallest value
             * in this group.
             *
             * indices[i] is the i-th smallest original index.
             */
            for (int i = 0; i < size; i++)
            {
                nums[indices[i]] = pairs[start + i][0];
            }

            /*
             * Move to the next group.
             */
            start = end + 1;
        }

        /*
         * nums now contains the lexicographically smallest
         * array that can be obtained.
         */
        return nums;
    }
}
