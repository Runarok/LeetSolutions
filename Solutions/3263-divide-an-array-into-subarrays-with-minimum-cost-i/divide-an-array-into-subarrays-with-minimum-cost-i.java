class Solution {
    public int minimumCost(int[] nums) {

        // Store the first element of the array
        int startElement = nums[0];

        // Initialize the smallest and second smallest values
        int firstMin = Integer.MAX_VALUE;
        int secondMin = Integer.MAX_VALUE;

        // Iterate through the array starting from index 1
        // because nums[0] is already stored as startElement
        for (int i = 1; i < nums.length; i++) {

            // If current element is smaller than the smallest found so far
            if (firstMin > nums[i]) {
                // Update secondMin before replacing firstMin
                secondMin = firstMin;
                firstMin = nums[i];

            // If current element is between firstMin and secondMin
            } else if (nums[i] < secondMin) {
                secondMin = nums[i];
            }
        }

        // Return the sum of the first element,
        // the smallest element, and the second smallest element
        return firstMin + secondMin + startElement;
    }
}
