class Solution {
    /**
     * Calculates the maximum possible sum by optionally performing XOR operations on
     * elements of the nums array. The XOR operation flips the parity state.
     * 
     * @param nums The array of integers.
     * @param k The integer used in XOR operation.
     * @param edges Unused in this implementation but given as input.
     * @return The maximum sum achievable.
     */
    public long maximumValueSum(int[] nums, int k, int[][] edges) {
        // Create a memoization table where:
        // memo[i][0] -> max sum starting from index i when current parity is odd
        // memo[i][1] -> max sum starting from index i when current parity is even
        long[][] memo = new long[nums.length][2];

        // Initialize all values with -1 to indicate uncomputed states
        for (long[] row : memo) {
            Arrays.fill(row, -1);
        }

        // Start from index 0 with parity = 1 (even number of XOR operations done)
        // According to the problem, we want an even number of XOR operations performed.
        return maxSumOfNodes(0, 1, nums, k, memo);
    }

    /**
     * Recursive helper method to compute maximum sum from a given index, keeping track
     * of parity of XOR operations done so far.
     * 
     * @param index Current index in the nums array.
     * @param isEven Indicates parity of number of XOR operations performed so far:
     *               1 = even number of XOR ops, 0 = odd number of XOR ops.
     * @param nums The input array.
     * @param k The integer used for XOR.
     * @param memo Memoization table to avoid recomputation.
     * @return Maximum sum achievable from index with given parity.
     */
    private long maxSumOfNodes(int index, int isEven, int[] nums, int k, long[][] memo) {
        // Base case: if we've considered all elements
        if (index == nums.length) {
            // If the number of XOR operations performed is even, return 0 (valid sum)
            // Otherwise, return Integer.MIN_VALUE to invalidate this scenario
            // (since problem states only even number of XOR operations is allowed)
            return isEven == 1 ? 0 : Integer.MIN_VALUE;
        }

        // If we have already computed the result for this state, return it
        if (memo[index][isEven] != -1) {
            return memo[index][isEven];
        }

        // Option 1: Do NOT perform XOR on the current element
        // Add nums[index] as-is and keep the parity unchanged
        long noXorDone = nums[index] + maxSumOfNodes(index + 1, isEven, nums, k, memo);

        // Option 2: Perform XOR operation on current element
        // XOR the current element with k and flip parity (0 -> 1 or 1 -> 0)
        long xorDone = (nums[index] ^ k) + maxSumOfNodes(index + 1, isEven ^ 1, nums, k, memo);

        // Memoize the maximum of the two options and return it
        memo[index][isEven] = Math.max(xorDone, noXorDone);
        return memo[index][isEven];
    }
}
