public class Solution {
    public int MaxDistance(int[] nums1, int[] nums2) {
        int i = 0; // pointer for nums1
        int j = 0; // pointer for nums2
        int maxDist = 0; // result

        // Traverse both arrays
        while (i < nums1.Length && j < nums2.Length) {

            // If current pair is valid
            if (nums1[i] <= nums2[j]) {
                // Update maximum distance
                maxDist = Math.Max(maxDist, j - i);

                // Try to increase distance by moving j forward
                j++;
            } else {
                // nums1[i] > nums2[j] → invalid pair
                // Move i forward to try smaller nums1[i]
                i++;
            }
        }

        return maxDist;
    }
}