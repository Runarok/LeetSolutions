func maximumUniqueSubarray(nums []int) int {
    // Map to track whether a number is in the current window
    seen := make(map[int]bool)

    // Initialize two pointers for the sliding window
    left, right := 0, 0

    // Variables to track the current sum of the window and the maximum sum found
    currSum, maxSum := 0, 0

    // Iterate through the array using the right pointer
    for right < len(nums) {
        // If nums[right] is not in the current window (i.e., unique so far)
        if !seen[nums[right]] {
            // Mark it as seen
            seen[nums[right]] = true

            // Add it to the current sum
            currSum += nums[right]

            // Update the max sum if the current sum is greater
            maxSum = max(maxSum, currSum)

            // Move the right end of the window forward
            right++
        } else {
            // If nums[right] is a duplicate, remove nums[left] from the window
            // until the duplicate is removed
            seen[nums[left]] = false
            currSum -= nums[left]
            left++
        }
    }

    // Return the maximum sum of a unique-element subarray
    return maxSum
}

// Helper function to return the maximum of two integers
func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
