class Solution {
    public int[] nodesBetweenCriticalPoints(ListNode head) {

        // We need at least 3 nodes to have even one critical point,
        // because a critical point must have both:
        // 1. A previous node
        // 2. A next node
        //
        // If the list has fewer than 3 nodes, there cannot be
        // two critical points.
        if (head == null || head.next == null || head.next.next == null) {
            return new int[] {-1, -1};
        }

        /*
         * We will keep track of three nodes:
         *
         * prev    -> node before the current node
         * curr    -> node we are checking
         * next    -> node after the current node
         *
         * Initially:
         *
         * prev = head
         * curr = head.next
         *
         * Then next = curr.next
         *
         * This allows us to determine whether curr is a local
         * maximum or local minimum.
         */
        ListNode prev = head;
        ListNode curr = head.next;

        /*
         * Position of the current node.
         *
         * We use 1-based indexing because the problem examples
         * describe nodes using positions such as 3rd, 5th, 6th.
         *
         * head is position 1
         * head.next is position 2
         *
         * So curr starts at position 2.
         */
        int position = 2;

        /*
         * firstCritical:
         * Position of the FIRST critical point we encounter.
         *
         * lastCritical:
         * Position of the MOST RECENT critical point.
         *
         * We need these to calculate the maximum distance:
         *
         * maximum distance = lastCritical - firstCritical
         *
         * Because the largest distance will always be between
         * the first and last critical points.
         */
        int firstCritical = -1;
        int lastCritical = -1;

        /*
         * minDistance starts with a very large value.
         *
         * Once we find two critical points, we calculate their
         * distance and update minDistance.
         */
        int minDistance = Integer.MAX_VALUE;

        /*
         * We stop when curr.next == null.
         *
         * Why?
         *
         * The last node cannot be a critical point because it
         * doesn't have a next node.
         */
        while (curr.next != null) {

            // The node after curr.
            ListNode next = curr.next;

            /*
             * Check whether curr is a local maximum:
             *
             *        prev       curr       next
             *          3          5          2
             *
             * curr must be STRICTLY greater than both neighbors.
             *
             * prev.val < curr.val
             * AND
             * curr.val > next.val
             *
             * We can write this as:
             *
             * curr.val > prev.val && curr.val > next.val
             */
            boolean isLocalMax =
                    curr.val > prev.val &&
                    curr.val > next.val;

            /*
             * Check whether curr is a local minimum:
             *
             *        prev       curr       next
             *          5          2          4
             *
             * curr must be STRICTLY smaller than both neighbors.
             *
             * prev.val > curr.val
             * AND
             * curr.val < next.val
             */
            boolean isLocalMin =
                    curr.val < prev.val &&
                    curr.val < next.val;

            /*
             * If either condition is true, curr is a critical point.
             */
            if (isLocalMax || isLocalMin) {

                /*
                 * If this is the FIRST critical point:
                 *
                 * We only save its position.
                 *
                 * We cannot calculate a distance yet because
                 * we need two critical points.
                 */
                if (firstCritical == -1) {
                    firstCritical = position;
                } else {

                    /*
                     * We already have at least one critical point.
                     *
                     * The distance from the previous critical point
                     * to the current critical point is:
                     *
                     * position - lastCritical
                     *
                     * This is enough to find the minimum distance.
                     */
                    int distance = position - lastCritical;

                    /*
                     * Keep the smallest distance we've seen.
                     */
                    minDistance = Math.min(minDistance, distance);
                }

                /*
                 * Whether this is the first critical point or not,
                 * the current point becomes the most recent critical
                 * point.
                 */
                lastCritical = position;
            }

            /*
             * Move all three pointers one step forward:
             *
             * prev -> curr
             * curr -> next
             *
             * We don't actually need to explicitly keep a "next"
             * pointer after this because it will be calculated
             * again at the beginning of the next iteration.
             */
            prev = curr;
            curr = next;

            // Move to the next position in the linked list.
            position++;
        }

        /*
         * If we found fewer than two critical points, then
         * minDistance was never calculated.
         *
         * In that case the required answer is [-1, -1].
         */
        if (firstCritical == -1 || firstCritical == lastCritical) {
            return new int[] {-1, -1};
        }

        /*
         * The maximum distance is simply the distance between
         * the FIRST and LAST critical points.
         *
         * Example:
         *
         * Critical points at positions:
         * 3, 5, 6
         *
         * Maximum distance:
         * 6 - 3 = 3
         */
        int maxDistance = lastCritical - firstCritical;

        /*
         * Return:
         *
         * [minimum distance, maximum distance]
         */
        return new int[] {minDistance, maxDistance};
    }
}
