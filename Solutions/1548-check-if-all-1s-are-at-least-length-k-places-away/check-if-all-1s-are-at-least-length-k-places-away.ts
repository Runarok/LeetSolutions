function kLengthApart(nums: number[], k: number): boolean {

    /**********************************************************************
     * PROBLEM SUMMARY
     * --------------------------------------------------------------------
     * We are given a binary array "nums" (an array consisting only of 0s
     * and 1s). We must determine whether EVERY pair of 1s in the array is
     * at least "k" zeros apart.
     *
     * That means:
     *    For any two 1s at positions i and j (with j > i),
     *    the number of zeros between them must be >= k.
     *
     * The number of zeros between them is:
     *      j - i - 1
     * If (j - i - 1) < k → return false.
     *
     * Example:
     *   nums = [1,0,0,0,1], k = 3
     *   1 at index 0 and 1 at index 4 → distance = 4 - 0 - 1 = 3 → OK
     *
     *   nums = [1,0,0,1], k = 3
     *   1 at 0, 1 at 3 → distance = 3 - 0 - 1 = 2 → NOT ENOUGH → false
     **********************************************************************/

    // This will store the index of the previous 1 we saw.
    // We initialize it to -1 to mean "we haven't seen any 1 yet".
    let previousOneIndex = -1;

    // Loop through every index of the nums array
    for (let i = 0; i < nums.length; i++) {

        // Check if the current element is 1
        if (nums[i] === 1) {

            /******************************************************************
             * If we have seen a previous 1 (meaning previousOneIndex != -1),
             * we must measure the distance between the current 1 and the last one.
             *
             * Distance formula:
             *    distance = i - previousOneIndex - 1
             *
             * Why "-1"?
             * Because if previousOneIndex = 0 and i = 3:
             *    positions: [0,1,2,3]
             *    zeros between them are at index 1 and 2 → count = 2
             *    That's (3 - 0 - 1) = 2
             ******************************************************************/

            if (previousOneIndex !== -1) {
                const distance = i - previousOneIndex - 1;

                // If the distance is smaller than k → condition fails
                if (distance < k) {
                    return false;  // we found a violation, no need to continue
                }
            }

            // Update the index of the last seen 1
            previousOneIndex = i;
        }
    }

    /**********************************************************************
     * If we finish the loop WITHOUT finding any violation, then all 1s
     * are properly spaced apart. Thus, we return true.
     **********************************************************************/
    return true;
}
