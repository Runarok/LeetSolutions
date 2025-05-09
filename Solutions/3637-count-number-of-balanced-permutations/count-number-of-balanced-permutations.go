const MOD = 1_000_000_007

// Optimized function to count the number of balanced permutations of the given digits string `num`
func countBalancedPermutations(num string) int {
	// Total sum of digits and length of the number string
	tot, n := 0, len(num)
	// Array to store the frequency of each digit (0-9)
	cnt := make([]int, 10)

	// Calculate the total sum of digits and the frequency of each digit
	for _, ch := range num {
		d := int(ch - '0')  // Convert char to integer
		cnt[d]++            // Increment the count for the corresponding digit
		tot += d            // Add the digit value to the total sum
	}

	// If the total sum is odd, it's impossible to split it into two equal halves
	if tot%2 != 0 {
		return 0
	}

	// The target sum for each half (since the sum needs to be divided evenly)
	target := tot / 2
	// The maximum number of odd-positioned elements that can be used
	maxOdd := (n + 1) / 2

	// Pre-calculate binomial coefficients (combinations) up to maxOdd
	comb := make([][]int, maxOdd+1)
	for i := range comb {
		comb[i] = make([]int, maxOdd+1)
		comb[i][i], comb[i][0] = 1, 1
		// Fill the combination table using Pascal's triangle
		for j := 1; j < i; j++ {
			comb[i][j] = (comb[i-1][j] + comb[i-1][j-1]) % MOD
		}
	}

	// psum[i] stores the cumulative count of digits greater than or equal to `i`
	psum := make([]int, 11)
	for i := 9; i >= 0; i-- {
		psum[i] = psum[i+1] + cnt[i]
	}

	// Memoization table for storing intermediate results during DFS
	// Using a map to reduce memory usage
	memo := make(map[[3]int]int)

	// Depth-First Search (DFS) function to explore possible configurations
	var dfs func(pos, curr, oddCnt int) int
	dfs = func(pos, curr, oddCnt int) int {
		// Base cases:
		// - If there aren't enough remaining digits to satisfy the oddCnt
		// - If the sum of the odd positions exceeds the target
		if oddCnt < 0 || psum[pos] < oddCnt || curr > target {
			return 0
		}

		// If all positions have been considered, check if the current sum equals the target
		if pos > 9 {
			if curr == target && oddCnt == 0 {
				return 1
			}
			return 0
		}

		// If the result for this state is already computed, return it from the memo map
		if res, exists := memo[[3]int{pos, curr, oddCnt}]; exists {
			return res
		}

		// Number of even-positioned slots that can still be filled
		evenCnt := psum[pos] - oddCnt
		res := 0

		// Calculate valid ranges for how many times the current digit can appear in odd positions
		start := max(0, cnt[pos]-evenCnt)
		end := min(cnt[pos], oddCnt)

		// Explore all valid counts for the current digit being placed in odd positions
		for i := start; i <= end; i++ {
			// Ways to place `i` instances of the current digit in odd positions and the remaining in even positions
			ways := comb[oddCnt][i] * comb[evenCnt][cnt[pos]-i] % MOD
			// Recurse to the next position, updating the current sum and the remaining odd count
			res = (res + ways*dfs(pos+1, curr+i*pos, oddCnt-i)%MOD) % MOD
		}

		// Memorize the result for the current state
		memo[[3]int{pos, curr, oddCnt}] = res
		return res
	}

	// Start the DFS from position 0 with sum 0 and maximum odd positions
	return dfs(0, 0, maxOdd)
}
