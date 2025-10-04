class Solution {
    fun maxArea(height: IntArray): Int {
        // Initialize two pointers: one at the beginning, one at the end
        var left = 0
        var right = height.size - 1

        // Variable to keep track of the maximum area found
        var maxArea = 0

        // Loop until the two pointers meet
        while (left < right) {
            // Calculate the height as the minimum of the two lines
            val minHeight = minOf(height[left], height[right])

            // Calculate the width between the two lines
            val width = right - left

            // Calculate the area with the current pair of lines
            val area = minHeight * width

            // Update maxArea if this area is larger
            maxArea = maxOf(maxArea, area)

            // Move the pointer pointing to the shorter line inward
            // because moving the taller line won’t help increase area
            if (height[left] < height[right]) {
                left++
            } else {
                right--
            }
        }

        // Return the maximum area found
        return maxArea
    }
}
