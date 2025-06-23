// kMirror returns the sum of the first n numbers that are palindromic in both base 10 and base k.
func kMirror(k int, n int) int64 {
	// Preallocate space to store base-k digits
	digit := make([]int, 100)

	// `left` is the starting range of numbers to generate palindromes from (e.g., 1, 10, 100...)
	// `count` is the number of k-mirror numbers found so far
	// `ans` accumulates the sum of found k-mirror numbers
	left, count, ans := 1, 0, int64(0)

	// Continue until we've found `n` k-mirror numbers
	for count < n {
		right := left * 10

		// `op = 0` for odd-length palindromes, `op = 1` for even-length palindromes
		for op := 0; op < 2; op++ {
			// Generate palindromes by mirroring `i`
			for i := left; i < right && count < n; i++ {
				combined := int64(i)
				x := i

				// For odd-length palindromes, drop the last digit before mirroring
				if op == 0 {
					x = i / 10
				}

				// Append the reverse of `x` to `i` to form a full palindrome
				for x > 0 {
					combined = combined*10 + int64(x%10)
					x /= 10
				}

				// Check if the palindrome is also a palindrome in base `k`
				if isPalindrome(combined, k, digit) {
					count++
					ans += combined
				}
			}
		}
		// Move to the next range of numbers (increase digit length)
		left = right
	}

	return ans
}

// isPalindrome checks if `x` is a palindrome in base `k`
func isPalindrome(x int64, k int, digit []int) bool {
	length := -1

	// Convert `x` to base `k` and store digits in `digit` slice
	for x > 0 {
		length++
		digit[length] = int(x % int64(k))
		x /= int64(k)
	}

	// Check if digits form a palindrome
	for i, j := 0, length; i < j; i, j = i+1, j-1 {
		if digit[i] != digit[j] {
			return false
		}
	}
	return true
}
