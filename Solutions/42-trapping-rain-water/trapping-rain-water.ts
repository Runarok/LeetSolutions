function trap(height: number[]): number {
    // Total water trapped
    let water = 0;

    // Edge case: if less than 3 bars, no water can be trapped
    if (height.length < 3) return 0;

    // Two pointers starting from left and right ends
    let left = 0;
    let right = height.length - 1;

    // Variables to keep track of the maximum height seen so far from left and right
    let leftMax = 0;
    let rightMax = 0;

    // Loop until the two pointers meet
    while (left <= right) {
        // Decide which pointer to move based on smaller height
        if (height[left] <= height[right]) {
            // If current left bar is smaller or equal, water trapped depends on leftMax
            if (height[left] >= leftMax) {
                // Update leftMax
                leftMax = height[left];
            } else {
                // Water trapped at this position is leftMax - height[left]
                water += leftMax - height[left];
            }
            // Move left pointer to the right
            left++;
        } else {
            // Current right bar is smaller, water trapped depends on rightMax
            if (height[right] >= rightMax) {
                // Update rightMax
                rightMax = height[right];
            } else {
                // Water trapped at this position is rightMax - height[right]
                water += rightMax - height[right];
            }
            // Move right pointer to the left
            right--;
        }
    }

    return water;
}
