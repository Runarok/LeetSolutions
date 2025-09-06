// get calculates a special count based on a pattern that involves powers of 2 and index tracking.
// It returns the cumulative weighted count up to a given number `num`.
func get(num int) int64 {
	var cnt int64  // To store the cumulative count
	i := 1         // Step/index counter, determines the weight applied at each level
	base := 1      // The start of the current block, which doubles every iteration (1, 2, 4, 8, ...)

	// Loop through blocks of size in powers of two until base exceeds the number
	for base <= num {
		end := base*2 - 1 // Calculate the end of the current block
		if end > num {
			end = num // Ensure we do not overshoot the upper bound
		}
		
		// Add the contribution of the current block:
		// The weight is based on (i+1)/2 and is multiplied by the number of elements in the block
		cnt += int64((i+1)/2) * int64(end-base+1)
		
		i++        // Move to the next index (used for weighting)
		base *= 2  // Move to the next block (doubles in size each time)
	}
	
	return cnt
}

// minOperations processes a list of queries and computes the total operations needed.
// Each query is a range [l, r], and it finds the number of "odd-weighted" positions between l and r.
func minOperations(queries [][]int) int64 {
	var res int64 // Store the total result across all queries

	for _, q := range queries {
		// q[0] is the starting index of the query (inclusive)
		// q[1] is the ending index of the query (inclusive)

		count1 := get(q[1])       // Get cumulative weighted count up to q[1]
		count2 := get(q[0] - 1)   // Get cumulative weighted count just before q[0]
		
		// The difference gives the total weight in range [q[0], q[1]]
		// The formula (diff + 1)/2 extracts the number of odd-weighted positions in that range
		res += (count1 - count2 + 1) / 2
	}

	return res
}
