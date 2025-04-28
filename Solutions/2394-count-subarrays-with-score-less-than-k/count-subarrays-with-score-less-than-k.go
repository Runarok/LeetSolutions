func countSubarrays(nums []int, k int64) int64 {
    n := len(nums)  // Get the length of the array
    var res, total int64  // Initialize variables for the result and the current sum of the window
    i := 0  // Initialize the left pointer of the sliding window
    
    // Loop through the array with the right pointer (j)
    for j := 0; j < n; j++ {
        total += int64(nums[j])  // Add the current element to the total sum of the window
        
        // While the score (sum * length) is greater than or equal to k, shrink the window from the left
        // The score is calculated as total * (j - i + 1)
        for i <= j && total*(int64(j-i+1)) >= k {
            total -= int64(nums[i])  // Subtract the element at the left of the window
            i++  // Move the left pointer to the right (shrink the window)
        }
        
        // Add the number of valid subarrays ending at index j
        // All subarrays from i to j are valid, and their count is (j - i + 1)
        res += int64(j - i + 1)
    }
    
    return res  // Return the final count of valid subarrays
}
