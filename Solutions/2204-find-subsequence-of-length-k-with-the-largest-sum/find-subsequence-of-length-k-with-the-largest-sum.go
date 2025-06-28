func maxSubsequence(nums []int, k int) []int {
	n := len(nums)

	// Create an auxiliary slice to hold each element's original index and value
	vals := make([][]int, n)
	for i := 0; i < n; i++ {
		vals[i] = []int{i, nums[i]} // Store [index, value]
	}

	// Sort the slice in descending order by value to find the k largest elements
	sort.Slice(vals, func(i, j int) bool {
		return vals[i][1] > vals[j][1]
	})

	// Keep only the first k largest elements
	// Then sort them by original index to preserve the order in the original array
	sort.Slice(vals[:k], func(i, j int) bool {
		return vals[i][0] < vals[j][0]
	})

	// Extract the values in the correct order
	res := make([]int, k)
	for i := 0; i < k; i++ {
		res[i] = vals[i][1]
	}

	return res
}
