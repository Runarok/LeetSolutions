class Solution {
    public boolean uniformArray(int[] nums1) {

        // ---------------------------------------------------------
        // We only care about whether each number is odd or even.
        //
        // If all numbers already have the same parity:
        //     - all odd  -> keep every number as it is
        //     - all even -> keep every number as it is
        //
        // So in this case the answer is immediately true.
        // ---------------------------------------------------------

        boolean hasOdd = false;
        boolean hasEven = false;

        // Check whether the array contains odd and even numbers.
        for (int num : nums1) {

            // num % 2 == 0 means the number is even.
            if (num % 2 == 0) {
                hasEven = true;
            }

            // num % 2 != 0 means the number is odd.
            else {
                hasOdd = true;
            }
        }

        // ---------------------------------------------------------
        // If we have both an odd and an even number, we can make
        // every number even.
        //
        // For example:
        //     nums1 = [2, 3, 5, 8]
        //
        // Keep even numbers:
        //     2 -> 2
        //     8 -> 8
        //
        // For odd numbers, subtract an even number:
        //     3 - 2 = 1   (still odd!)
        //
        // So instead, subtract an odd number:
        //     3 - 5 = -2  (even)
        //     5 - 3 = 2   (even)
        //
        // Since we have both parities, there is an odd number
        // available to subtract from every odd element.
        //
        // For an even element, simply keep it unchanged.
        //
        // Thus, all resulting values can be made even.
        // ---------------------------------------------------------

        if (hasOdd && hasEven) {
            return true;
        }

        // ---------------------------------------------------------
        // If we reach here, all numbers have the same parity.
        //
        // We can simply choose:
        //
        //     nums2[i] = nums1[i]
        //
        // for every i.
        //
        // Therefore all elements of nums2 already have the same
        // parity.
        // ---------------------------------------------------------

        return true;
    }
}
