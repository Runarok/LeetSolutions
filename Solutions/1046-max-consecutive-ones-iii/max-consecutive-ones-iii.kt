class Solution {
    fun longestOnes(nums: IntArray, k: Int): Int {

        // 'left' represents the beginning of our current window.
        var left = 0

        // Keep track of how many zeros are currently
        // inside the sliding window.
        var zeroCount = 0

        // This will store the longest valid window
        // we have found so far.
        var maxLength = 0

        // Expand the window by moving 'right' from
        // the beginning to the end of the array.
        for (right in nums.indices) {

            // If the current number is 0, we would need
            // to flip it to 1 in order for the entire
            // window to contain only 1s.
            if (nums[right] == 0) {
                zeroCount++
            }

            // If we now have more than k zeros,
            // this window is invalid because we are
            // only allowed to flip at most k zeros.
            //
            // Move the left side of the window forward
            // until the number of zeros becomes <= k again.
            while (zeroCount > k) {

                // If the element leaving the window is a 0,
                // decrease our zero count because it is no
                // longer part of the current window.
                if (nums[left] == 0) {
                    zeroCount--
                }

                // Move the left boundary one position forward.
                left++
            }

            // At this point, the window is guaranteed to contain
            // at most k zeros, so it is possible to flip all of
            // them and turn the entire window into 1s.
            //
            // The length of the current window is:
            //
            //     right - left + 1
            //
            // Update the maximum length if this window
            // is larger than anything we have seen before.
            maxLength = maxOf(
                maxLength,
                right - left + 1
            )
        }

        // Return the longest window that contains
        // at most k zeros.
        return maxLength
    }
}