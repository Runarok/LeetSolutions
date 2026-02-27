class Solution {

    public int minOperations(String s, int k) {
        // Count total number of '0's in the string
        int zeros = s.chars().map(x -> x == '0' ? 1 : 0).sum();

        // If zeros already divisible by k,
        // we can group them directly without any transformations
        if ((zeros % k) == 0) return zeros / k;

        int n = s.length();  // Total length of string

        // BFS queue: each element represents a possible count of zeros
        Queue<Integer> q = new ArrayDeque<>();
        q.add(zeros);

        // res = number of operations (BFS depth)
        int res = 1;

        /*
         * bounds array used for pruning:
         * bounds[parity][0] = minimum visited value with this parity
         * bounds[parity][1] = maximum visited value with this parity
         *
         * parity = 0 (even), 1 (odd)
         *
         * Why parity?
         * Each transformation changes zero count by increments of 2,
         * so parity never changes.
         */
        int[][] bounds = new int[2][2];

        // Initialize bounds for starting parity
        bounds[zeros & 1][0] = bounds[zeros & 1][1] = zeros;

        // Initialize opposite parity bounds to extreme values
        bounds[1 - (zeros & 1)][0] = Integer.MAX_VALUE;
        bounds[1 - (zeros & 1)][1] = Integer.MIN_VALUE;

        // BFS traversal
        while (!q.isEmpty()) {

            // Track min and max zero counts in this level
            int minv = Integer.MAX_VALUE;
            int maxv = Integer.MIN_VALUE;

            // Process current BFS layer
            for (int len = q.size(); len > 0; len--) {

                int h = q.poll();  // current number of zeros
                int t = n - h;     // number of ones

                /*
                 * Operation type 1:
                 * Convert up to k zeros and remaining from ones
                 */
                int x = Math.min(h, k);  // max zeros we can take

                if (t >= k - x) {
                    // New zero count after operation
                    int fst = h - x + (k - x);

                    minv = Math.min(minv, fst);
                    maxv = Math.max(maxv, fst);
                }

                /*
                 * Operation type 2:
                 * Convert up to k ones and remaining from zeros
                 */
                x = Math.min(t, k);  // max ones we can take

                if (h >= k - x) {
                    int snd = h - (k - x) + x;

                    minv = Math.min(minv, snd);
                    maxv = Math.max(maxv, snd);
                }
            }

            /*
             * All possible children in this round form
             * a sequence differing by 2 (same parity).
             */
            int ind = minv & 1;  // parity index
            int temp = minv;

            while (temp <= maxv) {

                // If divisible by k → solution found
                if ((temp % k) == 0)
                    return res + temp / k;

                /*
                 * Only add to queue if not already covered by bounds.
                 * This avoids revisiting the same parity interval.
                 */
                if (temp < bounds[ind][0] || temp > bounds[ind][1]) {
                    q.add(temp);
                    temp += 2;
                } else {
                    // Skip already visited interval
                    temp = bounds[ind][1] + 2;
                }
            }

            // Update visited bounds for this parity
            bounds[ind][0] = Math.min(bounds[ind][0], minv);
            bounds[ind][1] = Math.max(bounds[ind][1], maxv);

            // Move to next BFS level
            res++;
        }

        // If no solution found
        return -1;
    }
}