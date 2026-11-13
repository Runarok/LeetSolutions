class Solution {
    fun countNonDecreasingSubarrays(nums: IntArray, k: Int): Long {

        val n = nums.size

        // Stores the final answer.
        // We use Long because the number of subarrays can
        // be as large as n * (n + 1) / 2.
        var ans = 0L

        // Total number of increment operations required
        // to make the current sliding window non-decreasing.
        var operations = 0L

        // Max priority queue:
        // Stores pairs of (value, index).
        //
        // The element with the largest value stays at the top.
        // We use the index to identify elements that leave
        // the sliding window.
        //
        // Kotlin PriorityQueue is a min heap by default,
        // so we reverse the comparator to create a max heap.
        val pq = PriorityQueue<Pair<Int, Int>>(
            compareByDescending<Pair<Int, Int>> { it.first }
                .thenBy { it.second }
        )

        // cnt[i] stores the indices of elements that are
        // covered by the previous greater element at index i.
        //
        // In other words, these elements depend on nums[i]
        // as their previous maximum.
        val cnt = Array(n) { ArrayList<Int>() }

        // pos[i] stores the index of the first element to the
        // right of i whose value is greater than or equal to nums[i].
        //
        // If no such element exists, pos[i] = n.
        val pos = IntArray(n) { n }

        // Monotonic decreasing stack.
        // Stores indices, with values in decreasing order.
        val st = ArrayList<Int>()

        // Left boundary of the current sliding window.
        var left = 0

        // Iterate over every element as the right boundary.
        for (right in 0 until n) {

            // ------------------------------------------------
            // STEP 1: Maintain the monotonic decreasing stack.
            // ------------------------------------------------

            // Remove all previous elements whose values are
            // smaller than or equal to the current element.
            //
            // The current element becomes their first
            // greater-than-or-equal element on the right.
            while (st.isNotEmpty() &&
                nums[right] >= nums[st.last()]
            ) {

                val index = st.removeAt(st.size - 1)

                // Record the first greater-or-equal position.
                pos[index] = right
            }

            // If the stack is not empty, its top represents
            // the nearest previous greater element.
            //
            // The current index depends on that previous
            // greater element when making the window
            // non-decreasing.
            if (st.isNotEmpty()) {
                cnt[st.last()].add(right)
            }

            // Push the current index onto the stack.
            st.add(right)

            // ------------------------------------------------
            // STEP 2: Add the current element to the max heap.
            // ------------------------------------------------

            // Store both the value and its original index.
            pq.offer(Pair(nums[right], right))

            // The maximum value in the current window is
            // available at the top of the priority queue.
            //
            // To make the current element non-decreasing,
            // it might need to be increased to this maximum.
            //
            // Additional operations needed:
            // max(0, windowMaximum - currentElement)
            val maxValue = pq.peek().first

            operations += maxOf(
                0L,
                maxValue.toLong() - nums[right].toLong()
            )

            // ------------------------------------------------
            // STEP 3: Shrink the window if operations > k.
            // ------------------------------------------------

            while (operations > k.toLong()) {

                // When nums[left] leaves the window,
                // some elements may no longer need to be
                // increased because of nums[left].
                //
                // cnt[left] contains all elements directly
                // dependent on nums[left].
                for (i in cnt[left]) {

                    // Calculate how many elements in the
                    // dependent range are affected by removing
                    // nums[left].
                    //
                    // The range ends at:
                    // min(pos[i], right + 1)
                    //
                    // This ensures we only consider elements
                    // inside the current window.
                    val end = minOf(pos[i], right + 1)

                    val length = end - i

                    // The previous maximum contribution is
                    // nums[left] - nums[i].
                    //
                    // Removing nums[left] eliminates this
                    // contribution for the affected range.
                    val decrease =
                        (nums[left].toLong() - nums[i].toLong()) *
                        length.toLong()

                    // Update the total number of operations.
                    operations -= decrease
                }

                // Move the left boundary forward.
                left++
            }

            // ------------------------------------------------
            // STEP 4: Remove outdated elements from the heap.
            // ------------------------------------------------

            // The priority queue may still contain elements
            // that are no longer inside our sliding window.
            //
            // Remove them if their index is smaller than left.
            while (pq.isNotEmpty() && pq.peek().second < left) {
                pq.poll()
            }

            // ------------------------------------------------
            // STEP 5: Count valid subarrays.
            // ------------------------------------------------

            // Every subarray ending at 'right' and starting
            // anywhere between 'left' and 'right' is valid.
            //
            // Number of such subarrays:
            // right - left + 1
            ans += (right - left + 1).toLong()
        }

        // Return the total number of valid subarrays.
        return ans
    }
}
