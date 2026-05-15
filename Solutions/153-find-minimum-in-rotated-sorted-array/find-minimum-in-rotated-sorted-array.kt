class Solution {
    fun findMin(nums: IntArray): Int {

        // Left pointer starts at beginning
        var left = 0

        // Right pointer starts at end
        var right = nums.size - 1

        // Binary Search
        while (left < right) {

            // Find middle index
            val mid = left + (right - left) / 2

            /*
                Key Observation:

                In a rotated sorted array:
                - One half is always sorted
                - The minimum element lies in the unsorted half

                Compare middle element with right element
            */

            if (nums[mid] > nums[right]) {

                /*
                    Minimum is on the RIGHT side

                    Example:
                    [4,5,6,7,0,1,2]
                             ^
                           mid

                    nums[mid] = 7
                    nums[right] = 2

                    Since 7 > 2,
                    rotation point is after mid
                */

                left = mid + 1

            } else {

                /*
                    Minimum is at mid OR on the LEFT side

                    Example:
                    [4,5,6,0,1,2]
                           ^
                         mid

                    nums[mid] = 0
                    nums[right] = 2

                    Since 0 < 2,
                    the minimum could be mid itself
                */

                right = mid
            }
        }

        /*
            When left == right,
            we found the minimum element
        */

        return nums[left]
    }
}