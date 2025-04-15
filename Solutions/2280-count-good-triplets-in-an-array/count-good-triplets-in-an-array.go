package main

import "fmt"

// FenwickTree represents the Fenwick Tree (Binary Indexed Tree).
type FenwickTree struct {
	tree []int
	size int
}

// NewFenwickTree creates a new Fenwick Tree of the given size.
func NewFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		tree: make([]int, size+1), // Size + 1 because Fenwick Tree is 1-indexed.
		size: size,
	}
}

// Update increments the value at the given index in the Fenwick Tree.
func (ft *FenwickTree) Update(index int, delta int) {
	index++ // Adjust for 1-based indexing
	for index <= ft.size {
		ft.tree[index] += delta
		index += index & -index
	}
}

// Query returns the prefix sum from index 0 to the given index.
func (ft *FenwickTree) Query(index int) int {
	index++ // Adjust for 1-based indexing
	sum := 0
	for index > 0 {
		sum += ft.tree[index]
		index -= index & -index
	}
	return sum
}

// goodTriplets calculates the total number of good triplets.
func goodTriplets(nums1 []int, nums2 []int) int64 {
	n := len(nums1)

	// pos2 stores the index of each number in nums2
	pos2 := make([]int, n)
	for i := 0; i < n; i++ {
		pos2[nums2[i]] = i
	}

	// reversedIndexMapping stores the index of each value of nums1 in nums2
	reversedIndexMapping := make([]int, n)
	for i := 0; i < n; i++ {
		reversedIndexMapping[pos2[nums1[i]]] = i
	}

	// Create a Fenwick Tree to track the left-side counts
	tree := NewFenwickTree(n)

	var res int64
	// Iterate over each value in nums1
	for value := 0; value < n; value++ {
		pos := reversedIndexMapping[value]
		// Count how many elements are less than the current position in the Fenwick Tree (left side)
		left := tree.Query(pos)
		// Update the Fenwick Tree with the current position
		tree.Update(pos, 1)
		// Calculate how many elements are greater than the current position in nums2 (right side)
		right := int64(n-1-pos) - int64(value-left)
		// Add the number of valid triplets formed with the current element `value`
		res += int64(left) * right
	}

	return res
}
