class Solution {

    /*
     * We want to minimize:
     *   nums[0] + sum of (k - 1) smallest values
     * chosen from a sliding window of size `dist + 1`
     * that starts somewhere after index 0.
     *
     * Key idea:
     * - nums[0] is always included
     * - For the rest, we maintain the (k - 1) smallest elements
     *   inside a sliding window using two data structures.
     *
     * Time Complexity:
     *   O(N log D)
     *   - Each element is inserted/removed from a TreeSet or PriorityQueue
     *
     * Space Complexity:
     *   O(D)
     *   - We only store elements from the current window
     */
    fun minimumCost(
        nums: IntArray,
        k: Int,
        dist: Int,
    ): Long {

        /*
         * `small`:
         * - Contains the (k - 1) smallest elements in the current window
         * - Sorted DESCENDING by value (largest first)
         *   → lets us quickly remove the largest among the "small" elements
         *
         * We store (index, value) pairs so we can:
         * - Remove elements when they slide out of the window
         * - Break ties deterministically using index
         */
        val small = TreeSet<IntArray>(
            compareBy({ -it[1] }, { it[0] })
        )

        /*
         * `big`:
         * - Contains the remaining elements in the window
         * - Sorted ASCENDING by value (smallest first)
         *   → lets us promote the smallest element into `small` if needed
         */
        val big = PriorityQueue<IntArray>(
            compareBy({ it[1] }, { it[0] })
        )

        // Sum of values currently stored in `small`
        var smallSum = 0L

        /*
         * Initialize the first window:
         * - Window spans indices [1, dist + 1]
         * - We initially put everything into `small`
         */
        for (i in 1..dist + 1) {
            small.add(intArrayOf(i, nums[i]))
            smallSum += nums[i]
        }

        /*
         * Shrink `small` so that it contains exactly (k - 1) elements.
         * Move the largest elements into `big`.
         */
        while (small.size >= k) {
            val popped = checkNotNull(small.pollFirst())
            smallSum -= popped[1]
            big.offer(popped)
        }

        // Track the minimum sum of (k - 1) elements seen so far
        var minSmallSum = smallSum

        /*
         * Slide the window one position at a time.
         * `i` is the new element entering the window.
         */
        for (i in dist + 2..<nums.size) {

            // Index that is leaving the window
            val popIndex = i - dist - 1

            /*
             * If the outgoing element is in `small`, remove it
             * and update the sum.
             */
            if (
                nums[popIndex] <= small.first()[1] &&
                small.remove(intArrayOf(popIndex, nums[popIndex]))
            ) {
                smallSum -= nums[popIndex]
            }

            // Add the new element to `big` first
            big.offer(intArrayOf(i, nums[i]))

            /*
             * Clean up `big`:
             * Remove elements whose indices are no longer in the window.
             */
            while (big.isNotEmpty() && big.first()[0] <= popIndex) {
                big.poll()
            }

            /*
             * Rebalance the two structures so that:
             * - `small` has exactly (k - 1) elements
             * - `small` contains the smallest possible values
             */
            if (small.size < k - 1) {
                // Not enough elements in `small`, promote from `big`
                val firstBig = checkNotNull(big.poll())
                smallSum += firstBig[1]
                small.add(firstBig)

            } else if (small.first()[1] > big.first()[1]) {
                /*
                 * `small` contains an element larger than the smallest in `big`
                 * → swap them to improve the sum
                 */
                smallSum += big.first()[1] - small.first()[1]

                val firstSmall = checkNotNull(small.pollFirst())
                val firstBig = checkNotNull(big.poll())

                small.add(firstBig)
                big.add(firstSmall)
            }

            // Update the global minimum
            minSmallSum = minOf(minSmallSum, smallSum)
        }

        /*
         * Final answer:
         * - nums[0] is always included
         * - minSmallSum is the minimum sum of the other (k - 1) elements
         */
        return nums[0] + minSmallSum
    }
}
