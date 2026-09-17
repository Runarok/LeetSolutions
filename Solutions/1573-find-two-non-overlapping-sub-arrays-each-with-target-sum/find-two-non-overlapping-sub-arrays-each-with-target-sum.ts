function minSumOfLengths(arr: number[], target: number): number {
    const n = arr.length;

    /*
     * best[i] = minimum length of a valid subarray with sum == target
     *           that ends at or before index i.
     *
     * If there is no such subarray, best[i] will be Infinity.
     */
    const best: number[] = new Array(n).fill(Infinity);

    /*
     * Since all arr[i] are positive, we can use a sliding window.
     *
     * left  -> start of the current window
     * right -> end of the current window
     * sum   -> sum of arr[left ... right]
     */
    let left = 0;
    let sum = 0;

    /*
     * The answer starts as Infinity because we may not find
     * two valid non-overlapping subarrays.
     */
    let answer = Infinity;

    for (let right = 0; right < n; right++) {
        // Add the current element to our sliding window.
        sum += arr[right];

        /*
         * Because all numbers are positive, whenever sum is too large
         * we can safely move `left` forward to make the window smaller.
         */
        while (left <= right && sum > target) {
            sum -= arr[left];
            left++;
        }

        /*
         * If the current window has exactly the target sum,
         * then [left ... right] is a valid subarray.
         */
        if (sum === target) {
            const currentLength = right - left + 1;

            /*
             * We need TWO non-overlapping subarrays.
             *
             * The current subarray starts at `left`.
             * Therefore, the previous subarray must end before `left`.
             *
             * best[left - 1] contains the shortest valid subarray
             * that ends at or before left - 1.
             *
             * Combining them gives a valid pair of non-overlapping
             * subarrays.
             */
            if (left > 0 && best[left - 1] !== Infinity) {
                answer = Math.min(
                    answer,
                    currentLength + best[left - 1]
                );
            }

            /*
             * Store the shortest valid subarray seen so far.
             *
             * There may already be a shorter subarray ending before
             * this one, so take the minimum.
             */
            best[right] = Math.min(
                currentLength,
                right > 0 ? best[right - 1] : Infinity
            );
        } else {
            /*
             * No valid subarray ends at `right`.
             *
             * However, a valid subarray may have ended earlier,
             * so carry the previous best value forward.
             */
            best[right] = right > 0 ? best[right - 1] : Infinity;
        }
    }

    /*
     * If answer is still Infinity, we could not find two
     * non-overlapping subarrays whose sums are target.
     */
    return answer === Infinity ? -1 : answer;
}
