class Solution {
    public int firstStableIndex(int[] nums, int k) {

        int n = nums.length;

        /*
         * suffixMin[i] will store the minimum value
         * among nums[i], nums[i + 1], ..., nums[n - 1].
         *
         * For example:
         * nums = [5, 0, 1, 4]
         *
         * suffixMin = [0, 0, 1, 4]
         *
         * This allows us to quickly find:
         * min(nums[i..n-1])
         */
        int[] suffixMin = new int[n];

        // The last element is the minimum of the suffix
        // containing only itself.
        suffixMin[n - 1] = nums[n - 1];

        /*
         * Build the suffix minimum array from right to left.
         *
         * At every index i:
         *
         * suffixMin[i] = min(
         *     nums[i],
         *     suffixMin[i + 1]
         * )
         */
        for (int i = n - 2; i >= 0; i--) {
            suffixMin[i] = Math.min(nums[i], suffixMin[i + 1]);
        }

        /*
         * prefixMax stores the maximum value
         * from nums[0] through nums[i].
         *
         * We don't actually need a separate array for this.
         * We can maintain the prefix maximum while scanning
         * from left to right.
         */
        int prefixMax = nums[0];

        /*
         * We need the SMALLEST stable index,
         * so we scan from left to right.
         */
        for (int i = 0; i < n; i++) {

            /*
             * Update the maximum of nums[0..i].
             *
             * For example, if nums = [5, 0, 1, 4]:
             *
             * i = 0 -> prefixMax = 5
             * i = 1 -> prefixMax = 5
             * i = 2 -> prefixMax = 5
             * i = 3 -> prefixMax = 5
             */
            prefixMax = Math.max(prefixMax, nums[i]);

            /*
             * suffixMin[i] gives us:
             *
             * min(nums[i..n-1])
             *
             * Therefore:
             *
             * instability score =
             * max(nums[0..i]) - min(nums[i..n-1])
             */
            int instability = prefixMax - suffixMin[i];

            /*
             * If the instability score is at most k,
             * this index is stable.
             *
             * Since we're scanning from left to right,
             * this is automatically the FIRST stable index.
             */
            if (instability <= k) {
                return i;
            }
        }

        /*
         * We checked every index and none was stable.
         */
        return -1;
    }
}
