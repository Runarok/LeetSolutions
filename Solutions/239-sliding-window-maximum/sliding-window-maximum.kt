class Solution {
    fun maxSlidingWindow(nums: IntArray, k: Int): IntArray {

        // There are exactly:
        //
        // nums.size - k + 1
        //
        // different windows.
        //
        // Example:
        // nums has 8 elements and k = 3
        //
        // Number of windows = 8 - 3 + 1 = 6
        val result = IntArray(nums.size - k + 1)

        // This deque stores INDICES, not the actual values.
        //
        // The indices in the deque will have their
        // corresponding values in decreasing order.
        //
        // For example, if:
        //
        // nums = [1, 3, -1]
        //
        // the deque could contain:
        //
        // [1, 2]
        //
        // because:
        //
        // nums[1] = 3
        // nums[2] = -1
        //
        // They are in decreasing order: 3 > -1.
        val deque = java.util.ArrayDeque<Int>()

        // This tells us where to place the next answer.
        var resultIndex = 0

        // Process every element as the right side
        // of the sliding window.
        for (right in nums.indices) {

            // ----------------------------------------------------
            // STEP 1:
            // Remove indices that are outside the current window.
            // ----------------------------------------------------
            //
            // The current window is:
            //
            // [right - k + 1 ... right]
            //
            // Therefore, any index smaller than:
            //
            // right - k + 1
            //
            // is no longer inside the window.
            val windowStart = right - k + 1

            while (
                deque.isNotEmpty() &&
                deque.peekFirst() < windowStart
            ) {
                // Remove the oldest/out-of-window index.
                deque.pollFirst()
            }

            // ----------------------------------------------------
            // STEP 2:
            // Maintain decreasing values in the deque.
            // ----------------------------------------------------
            //
            // Suppose:
            //
            // nums = [1, 3, -1]
            //
            // and we are processing 3.
            //
            // The previous index (0) contains 1.
            //
            // Since 3 is greater than 1, index 0 can NEVER
            // be the maximum of this window again.
            //
            // Why?
            //
            // The newer element 3 is:
            //   - larger than 1
            //   - going to remain in the window longer
            //
            // So index 0 is useless and can be removed.
            while (
                deque.isNotEmpty() &&
                nums[deque.peekLast()] <= nums[right]
            ) {
                // Remove smaller values from the back.
                deque.pollLast()
            }

            // Add the current index to the back.
            //
            // Because we removed every smaller/equal value
            // first, the deque remains decreasing by value.
            deque.addLast(right)

            // ----------------------------------------------------
            // STEP 3:
            // Once we have processed k elements, we have
            // a complete sliding window.
            // ----------------------------------------------------
            //
            // The first complete window ends at index k - 1.
            //
            // So we only start adding answers when:
            //
            // right >= k - 1
            if (right >= k - 1) {

                // The front of the deque always contains the
                // index of the largest value in the current
                // sliding window.
                result[resultIndex] = nums[deque.peekFirst()]

                // Move to the next position in the result.
                resultIndex++
            }
        }

        // Return the maximum value from every sliding window.
        return result
    }
}