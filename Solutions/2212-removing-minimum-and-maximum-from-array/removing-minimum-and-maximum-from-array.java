class Solution {
    public int minimumDeletions(int[] nums) {

        int n = nums.length;

        // ---------------------------------------------------------
        // Step 1:
        // Find the index of the minimum and maximum elements.
        // ---------------------------------------------------------
        int minIndex = 0;
        int maxIndex = 0;

        for (int i = 0; i < n; i++) {

            // Update the index of the minimum element
            if (nums[i] < nums[minIndex]) {
                minIndex = i;
            }

            // Update the index of the maximum element
            if (nums[i] > nums[maxIndex]) {
                maxIndex = i;
            }
        }

        // ---------------------------------------------------------
        // Step 2:
        // We don't really care which one is minimum or maximum.
        //
        // Let:
        // left  = index of the element that appears first
        // right = index of the element that appears later
        //
        // This makes the three possible deletion strategies
        // easier to calculate.
        // ---------------------------------------------------------
        int left = Math.min(minIndex, maxIndex);
        int right = Math.max(minIndex, maxIndex);

        // ---------------------------------------------------------
        // There are only 3 useful ways to remove both elements:
        //
        // 1. Remove everything from the FRONT
        //    We need to delete through 'right'.
        //
        //    Number of deletions = right + 1
        //
        // 2. Remove everything from the BACK
        //    We need to delete from 'left' to the end.
        //
        //    Number of deletions = n - left
        //
        // 3. Remove the first element from the FRONT
        //    and the remaining elements from the BACK.
        //
        //    Delete 'left + 1' elements from the front,
        //    then 'n - right' elements from the back.
        //
        //    Total = (left + 1) + (n - right)
        // ---------------------------------------------------------

        int removeFromFront = right + 1;

        int removeFromBack = n - left;

        int removeFromBoth =
                (left + 1) + (n - right);

        // ---------------------------------------------------------
        // Return the smallest of the three possible answers.
        // ---------------------------------------------------------
        return Math.min(
                removeFromFront,
                Math.min(removeFromBack, removeFromBoth)
        );
    }
}
