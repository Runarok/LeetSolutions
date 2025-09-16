package main

import (
	"fmt"
)

// Helper function to calculate GCD using Euclidean algorithm
func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

// Helper function to calculate LCM
func lcm(a, b int) int {
	return a / gcd(a, b) * b
}

// Main function to replace adjacent non-coprime numbers with their LCM
func replaceNonCoprimes(nums []int) []int {
	// Use a stack to keep track of the current sequence
	stack := []int{}

	// Iterate over each number in the input array
	for _, num := range nums {
		// Push current number onto the stack
		stack = append(stack, num)

		// While the top two elements are non-coprime, replace them with their LCM
		for len(stack) >= 2 {
			n := len(stack)
			a, b := stack[n-2], stack[n-1]

			if gcd(a, b) > 1 {
				// Replace them with LCM
				l := lcm(a, b)
				stack = stack[:n-2] // Remove the last two
				stack = append(stack, l) // Push the LCM
			} else {
				// Stop merging if they are coprime
				break
			}
		}
	}

	return stack
}
