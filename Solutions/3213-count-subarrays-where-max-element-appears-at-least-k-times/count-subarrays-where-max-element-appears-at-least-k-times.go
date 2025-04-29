func countSubarrays(nums []int, k int) int64 {
    n := len(nums) // Get the length of the array
    maxElem := -1  // Initialize the variable to track the maximum element in the array
    
    // Find the maximum element in the array
    for _, num := range nums {
        if num > maxElem {
            maxElem = num
        }
    }

    count := int64(0)  // To store the number of valid subarrays
    left := 0          // Left pointer of the sliding window
    maxCount := 0      // To track how many times the maximum element appears in the current window

    // Iterate over the array with the right pointer
    for right := 0; right < n; right++ {
        // If the current element is the maximum element, increment the count of maxElem in the window
        if nums[right] == maxElem {
            maxCount++
        }

        // While the current window has at least 'k' occurrences of the maximum element
        for maxCount >= k {
            // Add the number of subarrays ending at 'right' that start from any index between 'left' and 'right'
            // All these subarrays will contain the maximum element at least 'k' times
            count += int64(n - right)  // Add all subarrays ending at 'right' and starting from any index >= left

            // Move the left pointer to shrink the window and decrease the count of maxElem if needed
            if nums[left] == maxElem {
                maxCount--  // Decrease the count of maxElem in the window
            }
            left++  // Shrink the window from the left
        }
    }

    return count  // Return the total number of valid subarrays
}
