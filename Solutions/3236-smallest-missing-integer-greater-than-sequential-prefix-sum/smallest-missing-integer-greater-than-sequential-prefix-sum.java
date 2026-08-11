class Solution {
    public int missingInteger(int[] nums) {

        // ---------------------------------------------------------
        // Step 1:
        // Find the longest sequential prefix.
        //
        // A sequential prefix means:
        // nums[i] == nums[i - 1] + 1
        //
        // For example:
        // [3, 4, 5, 1, 12]
        //  ^-------^
        // The longest sequential prefix is [3, 4, 5].
        // ---------------------------------------------------------

        int sum = nums[0];

        // Start from index 1 because nums[0] is always
        // considered a sequential prefix by itself.
        int i = 1;

        while (i < nums.length) {

            // Check whether the current number is exactly
            // one greater than the previous number.
            if (nums[i] == nums[i - 1] + 1) {

                // If it is sequential, add it to the sum.
                sum += nums[i];

                // Move to the next element.
                i++;

            } else {

                // The sequential prefix ends here.
                break;
            }
        }

        // ---------------------------------------------------------
        // At this point, 'sum' is the sum of the longest
        // sequential prefix.
        //
        // Example:
        // nums = [1, 2, 3, 2, 5]
        //
        // Longest sequential prefix = [1, 2, 3]
        // sum = 1 + 2 + 3 = 6
        // ---------------------------------------------------------


        // ---------------------------------------------------------
        // Step 2:
        // We need the smallest integer that:
        //
        // 1. Is greater than or equal to 'sum'
        // 2. Does NOT exist anywhere in nums
        //
        // So we start checking from 'sum' and keep increasing
        // until we find a number that isn't present in nums.
        // ---------------------------------------------------------

        int candidate = sum;

        while (true) {

            // Assume the candidate is not present in the array.
            boolean found = false;

            // Search the entire array for the candidate.
            for (int num : nums) {

                if (num == candidate) {
                    found = true;
                    break;
                }
            }

            // If the candidate was not found, this is exactly
            // the smallest missing integer we are looking for.
            if (!found) {
                return candidate;
            }

            // Otherwise, the candidate exists in nums,
            // so try the next integer.
            candidate++;
        }
    }
}