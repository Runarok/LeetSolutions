// findKDistantIndices returns all indices i in the nums slice such that
// there exists at least one index j with nums[j] == key and abs(i - j) <= k.
func findKDistantIndices(nums []int, key int, k int) []int {
	var res []int           // Result slice to store the qualifying indices
	n := len(nums)          // Length of the nums slice

	// Iterate through each index i in nums
	for i := 0; i < n; i++ {
		// For each i, check every index j in nums
		for j := 0; j < n; j++ {
			// Check if nums[j] matches the key and the absolute distance is within k
			if nums[j] == key && abs(i-j) <= k {
				// If conditions are satisfied, append i to result slice
				res = append(res, i)
				break // Stop checking further j's for this i to avoid duplicates
			}
		}
	}
	return res // Return the list of valid indices
}

// abs returns the absolute value of an integer x.
func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
