// f calculates how many products nums1[i] * nums2[j] are <= v for a fixed nums1[i] = x1.
// This uses binary search on nums2 (assumed to be sorted) and returns the count of valid j's.
func f(nums2 []int, x1 int64, v int64) int {
	n2 := len(nums2)
	left, right := 0, n2-1

	// Binary search to find how many elements in nums2 satisfy the condition
	for left <= right {
		mid := (left + right) / 2
		prod := int64(nums2[mid]) * x1

		// If x1 >= 0: we want prod <= v
		// If x1 < 0: we want prod > v (because multiplying by negative flips the inequality)
		if (x1 >= 0 && prod <= v) || (x1 < 0 && prod > v) {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	// For positive x1: left gives count of values with product <= v
	// For negative x1: n2 - left gives count of values with product <= v
	if x1 >= 0 {
		return left
	} else {
		return n2 - left
	}
}

// kthSmallestProduct finds the k-th smallest product of nums1[i] * nums2[j]
// Assumes both arrays are sorted. Time complexity is O((n1 + n2) * log(range)).
func kthSmallestProduct(nums1 []int, nums2 []int, k int64) int64 {
	n1 := len(nums1)
	left, right := int64(-1e10), int64(1e10) // Range for possible products

	// Binary search over the value of the product
	for left <= right {
		mid := (left + right) / 2
		count := int64(0)

		// Count how many products <= mid
		for i := 0; i < n1; i++ {
			count += int64(f(nums2, int64(nums1[i]), mid))
		}

		// Adjust the search range based on the count
		if count < k {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	// left is now the smallest value such that there are at least k products <= left
	return left
}
