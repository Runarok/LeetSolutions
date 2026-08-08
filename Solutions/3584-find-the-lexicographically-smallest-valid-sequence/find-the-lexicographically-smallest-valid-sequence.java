class Solution {
    public int[] validSequence(String word1, String word2) {

        int n = word1.length();
        int m = word2.length();

        /*
         * last[j] = the index in word1 where we can place word2[j]
         * while still being able to match:
         *
         *     word2[j], word2[j+1], ..., word2[m-1]
         *
         * exactly as a subsequence.
         *
         * We build this from right to left.
         *
         * Example:
         *
         * word1 = "bacdc"
         * word2 = "abc"
         *
         * For the suffix "c", last[2] = 4
         * For the suffix "bc", last[1] = 2
         * For the suffix "abc", last[0] = 1
         */
        int[] last = new int[m];

        // -1 means that this suffix cannot be matched exactly.
        java.util.Arrays.fill(last, -1);

        int i = n - 1;
        int j = m - 1;

        /*
         * Greedily match word2 from the END of word1.
         *
         * Because we scan word1 backwards, the positions we choose
         * are as far to the right as possible.
         */
        while (i >= 0 && j >= 0) {

            if (word1.charAt(i) == word2.charAt(j)) {
                last[j] = i;
                j--;
            }

            i--;
        }

        /*
         * Now construct the answer from left to right.
         *
         * We are allowed to have at most ONE mismatch.
         *
         * canSkip == true means we have not used our one mismatch yet.
         */
        int[] ans = new int[m];

        boolean canSkip = true;

        // j = current position in word2 that we need to fill.
        j = 0;

        /*
         * Scan word1 from left to right.
         *
         * This is what makes the answer lexicographically smallest:
         * we always take the earliest possible index.
         */
        for (i = 0; i < n && j < m; i++) {

            /*
             * Case 1:
             *
             * The current character already matches word2[j].
             *
             * Taking this index is always safe because choosing an
             * earlier index leaves at least as much room for the rest
             * of word2.
             */
            if (word1.charAt(i) == word2.charAt(j)) {

                ans[j] = i;
                j++;
            }

            /*
             * Case 2:
             *
             * The current character does NOT match word2[j].
             *
             * We can use our one allowed modification here.
             *
             * But we must make sure that the remaining suffix
             * word2[j+1 ... m-1] can still be matched EXACTLY.
             */
            else if (canSkip) {

                /*
                 * If j is the last character of word2, there is
                 * nothing left to match, so we can always use this
                 * position as our one mismatch.
                 *
                 * Otherwise:
                 *
                 * last[j + 1]
                 *
                 * is the position of word2[j+1] in an exact matching
                 * of the remaining suffix.
                 *
                 * Therefore, we need:
                 *
                 *     i < last[j + 1]
                 *
                 * so that the entire remaining suffix occurs after i.
                 *
                 * If last[j+1] == -1, the suffix cannot be matched,
                 * so using the mismatch here would make the sequence
                 * impossible.
                 */
                if (j == m - 1 || (last[j + 1] != -1 && i < last[j + 1])) {

                    // Use our one allowed mismatch.
                    canSkip = false;

                    ans[j] = i;
                    j++;
                }
            }
        }

        /*
         * If j == m, we successfully selected an index for every
         * character of word2.
         *
         * Otherwise, it is impossible to form a valid sequence.
         */
        if (j == m) {
            return ans;
        }

        return new int[0];
    }
}