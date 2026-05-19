class Solution {
    fun getCommon(nums1: IntArray, nums2: IntArray): Int {
        
        // Pointer for nums1
        var i = 0
        
        // Pointer for nums2
        var j = 0

        // Traverse both arrays
        while (i < nums1.size && j < nums2.size) {

            // If both elements are equal,
            // we found the smallest common element
            if (nums1[i] == nums2[j]) {
                return nums1[i]
            }

            // Move the pointer of the smaller element
            if (nums1[i] < nums2[j]) {
                i++
            } else {
                j++
            }
        }

        // No common element found
        return -1
    }
}