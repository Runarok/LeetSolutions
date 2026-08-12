class Solution {
    public int maxSubarrayLength(int[] nums, int k) {

        // HashMap stores:
        // key   -> the number in nums
        // value -> how many times that number appears
        //        in the current sliding window
        Map<Integer, Integer> freq = new HashMap<>();

        // 'left' represents the beginning of our window.
        int left = 0;

        // Stores the maximum valid window length found so far.
        int maxLength = 0;

        // Expand the window one element at a time.
        for (int right = 0; right < nums.length; right++) {

            // Add nums[right] to the current window.
            // If it is not already in the map, its frequency is 0.
            // Then increase its frequency by 1.
            freq.put(nums[right], freq.getOrDefault(nums[right], 0) + 1);

            // If nums[right] now occurs more than k times,
            // the current window is no longer "good".
            //
            // We keep removing elements from the left side
            // until the frequency of nums[right] becomes <= k.
            while (freq.get(nums[right]) > k) {

                // Remove nums[left] from the window.
                freq.put(nums[left], freq.get(nums[left]) - 1);

                // Move the left boundary to the right.
                left++;
            }

            // At this point, the window [left, right] is good.
            //
            // Its length is:
            // right - left + 1
            //
            // Update the maximum length if this window is larger.
            maxLength = Math.max(maxLength, right - left + 1);
        }

        // Return the length of the longest good subarray.
        return maxLength;
    }
}