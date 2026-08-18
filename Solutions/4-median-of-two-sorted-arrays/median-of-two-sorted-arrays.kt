class Solution {
    fun findMedianSortedArrays(nums1: IntArray, nums2: IntArray): Double {

        // We always perform binary search on the smaller array.
        //
        // This guarantees that the binary search takes
        // O(log(min(m, n))) time, which satisfies the required
        // O(log(m + n)) complexity.
        if (nums1.size > nums2.size) {
            return findMedianSortedArrays(nums2, nums1)
        }

        val m = nums1.size
        val n = nums2.size

        // We are going to split both arrays into:
        //
        //     LEFT | RIGHT
        //
        // The left side should contain half of all elements.
        //
        // If the total number of elements is odd, the left side
        // will contain one extra element.
        val total = m + n
        val half = (total + 1) / 2

        // Binary search boundaries for the partition in nums1.
        //
        // leftPartition can range from 0 to m.
        //
        // 0 means nothing from nums1 is on the left.
        // m means everything from nums1 is on the left.
        var low = 0
        var high = m

        while (low <= high) {

            // Choose how many elements from nums1 should be
            // placed on the left side.
            val partition1 = (low + high) / 2

            // The remaining elements needed on the left side
            // must come from nums2.
            val partition2 = half - partition1

            // Find the largest element on the left side of nums1.
            //
            // If partition1 == 0, there is no element on the
            // left side of nums1, so we use negative infinity.
            val left1 =
                if (partition1 == 0) {
                    Int.MIN_VALUE
                } else {
                    nums1[partition1 - 1]
                }

            // Find the smallest element on the right side of nums1.
            //
            // If partition1 == m, there is no element on the
            // right side of nums1, so we use positive infinity.
            val right1 =
                if (partition1 == m) {
                    Int.MAX_VALUE
                } else {
                    nums1[partition1]
                }

            // Do the same thing for nums2.
            val left2 =
                if (partition2 == 0) {
                    Int.MIN_VALUE
                } else {
                    nums2[partition2 - 1]
                }

            val right2 =
                if (partition2 == n) {
                    Int.MAX_VALUE
                } else {
                    nums2[partition2]
                }

            // We have found the correct partition when:
            //
            //     left1 <= right2
            //
            // AND
            //
            //     left2 <= right1
            //
            // This means every element on the left side is
            // less than or equal to every element on the right side.
            if (left1 <= right2 && left2 <= right1) {

                // If the total number of elements is odd,
                // the median is simply the largest element
                // on the left side.
                if (total % 2 == 1) {
                    return maxOf(left1, left2).toDouble()
                }

                // If the total number of elements is even,
                // the median is the average of:
                //
                //     largest element on the left
                //     smallest element on the right
                //
                val maxLeft = maxOf(left1, left2)
                val minRight = minOf(right1, right2)

                // Convert to Double before division so that
                // we don't accidentally perform integer division.
                return (maxLeft.toDouble() + minRight.toDouble()) / 2.0
            }

            // If left1 is too large, our partition in nums1
            // is too far to the right.
            //
            // Example:
            //
            //     left1 > right2
            //
            // means we have taken too many elements from nums1.
            // Move the partition to the left.
            if (left1 > right2) {
                high = partition1 - 1
            }

            // Otherwise, left2 is too large.
            //
            // This means we haven't taken enough elements from
            // nums1, so we need to move its partition to the right.
            else {
                low = partition1 + 1
            }
        }

        // The input arrays are guaranteed to be sorted,
        // so a valid partition must always exist.
        //
        // This line is only here to satisfy Kotlin's requirement
        // that the function returns a value on every possible path.
        return 0.0
    }
}