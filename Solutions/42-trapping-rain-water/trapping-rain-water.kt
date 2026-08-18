class Solution {
    fun trap(height: IntArray): Int {

        // We need at least 3 bars to trap any water.
        if (height.size < 3) {
            return 0
        }

        // Two pointers start at the two ends of the array.
        var left = 0
        var right = height.lastIndex

        // Highest bar encountered from the left side.
        var leftMax = 0

        // Highest bar encountered from the right side.
        var rightMax = 0

        // Total amount of trapped water.
        var water = 0

        // Continue until the two pointers meet.
        while (left < right) {

            // We process the side with the smaller
            // current height.
            //
            // Why?
            // If height[left] <= height[right], then the
            // right side already has a wall at least as high
            // as height[left]. Therefore, the amount of water
            // at the left position can be determined entirely
            // by leftMax.
            if (height[left] <= height[right]) {

                // If the current bar is higher than anything
                // we've previously seen from the left,
                // this becomes our new left boundary.
                if (height[left] >= leftMax) {
                    leftMax = height[left]
                } else {
                    // Otherwise, leftMax is taller than the
                    // current bar, so water can be trapped here.
                    //
                    // For example:
                    //
                    // leftMax = 3
                    // height[left] = 1
                    //
                    // We can store:
                    //
                    // 3 - 1 = 2 units of water.
                    water += leftMax - height[left]
                }

                // Move the left pointer toward the center.
                left++

            } else {

                // We are processing the right side because
                // its current height is smaller.
                //
                // If this bar is higher than anything we've
                // seen from the right, it becomes the new
                // right boundary.
                if (height[right] >= rightMax) {
                    rightMax = height[right]
                } else {
                    // Otherwise, rightMax is taller than the
                    // current bar, so water can be trapped here.
                    water += rightMax - height[right]
                }

                // Move the right pointer toward the center.
                right--
            }
        }

        // Return the total amount of trapped water.
        return water
    }
}