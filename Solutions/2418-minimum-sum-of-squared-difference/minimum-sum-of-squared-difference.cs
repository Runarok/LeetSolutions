public class Solution {
    public long MinSumSquareDiff(int[] nums1, int[] nums2, int k1, int k2) {

        int n = nums1.Length;

        // Step 1: Calculate the absolute difference between
        // corresponding elements of nums1 and nums2.
        int[] diff = new int[n];

        // Find the maximum difference so we know the search range.
        int maxDiff = 0;

        for (int i = 0; i < n; i++) {
            diff[i] = Math.Abs(nums1[i] - nums2[i]);

            if (diff[i] > maxDiff) {
                maxDiff = diff[i];
            }
        }

        // We can modify nums1 k1 times and nums2 k2 times.
        // Both operations can reduce the absolute difference by 1.
        // Therefore, the total number of available operations is k1 + k2.
        long k = (long)k1 + k2;

        // If we have enough operations to reduce every difference to zero,
        // the minimum possible sum of squared differences is zero.
        long totalDiff = 0;

        for (int i = 0; i < n; i++) {
            totalDiff += diff[i];
        }

        if (totalDiff <= k) {
            return 0;
        }

        // Step 2: Binary search for the smallest maximum difference
        // that can be achieved using at most k operations.
        //
        // low  = 0, because differences cannot be negative.
        // high = maxDiff, because that is the current maximum difference.
        int low = 0;
        int high = maxDiff;

        while (low < high) {

            // Find the middle value without risking integer overflow.
            int mid = low + (high - low) / 2;

            // Count how many operations are required to make every
            // difference less than or equal to mid.
            long operationsNeeded = 0;

            for (int i = 0; i < n; i++) {

                // If a difference is greater than mid, reduce it to mid.
                // For example:
                // difference = 8, mid = 5
                // operations needed = 8 - 5 = 3.
                if (diff[i] > mid) {
                    operationsNeeded += diff[i] - mid;
                }
            }

            // If we can achieve this maximum difference within our budget,
            // try an even smaller maximum difference.
            if (operationsNeeded <= k) {
                high = mid;
            }
            // Otherwise, we need too many operations, so allow
            // a larger maximum difference.
            else {
                low = mid + 1;
            }
        }

        // At this point, low is the smallest achievable maximum difference.
        int target = low;

        // Step 3: Reduce every difference greater than target down to target.
        // This uses the minimum operations required to achieve target.
        long operationsUsed = 0;

        for (int i = 0; i < n; i++) {
            if (diff[i] > target) {
                operationsUsed += diff[i] - target;
                diff[i] = target;
            }
        }

        // Step 4: Calculate how many operations remain.
        long remaining = k - operationsUsed;

        // We may still have operations left because reducing every difference
        // to target can use fewer than k operations.
        //
        // To minimize the sum of squares, use remaining operations to reduce
        // some differences equal to target by one.
        //
        // Example:
        // [5, 5, 3], target = 5
        // Reducing a 5 to 4 lowers its square from 25 to 16.
        // This is better than reducing a 3 to 2, which lowers its square
        // from 9 to 4.
        //
        // The binary search guarantees that we cannot reduce ALL differences
        // to target - 1 within k operations. Therefore, there are enough
        // differences equal to target to use all remaining operations.

        for (int i = 0; i < n && remaining > 0; i++) {
            if (diff[i] == target) {
                diff[i]--;
                remaining--;
            }
        }

        // Step 5: Calculate the final sum of squared differences.
        // Use long because the sum can exceed the range of int.
        long answer = 0;

        for (int i = 0; i < n; i++) {
            answer += (long)diff[i] * diff[i];
        }

        return answer;
    }
}