// longestSubsequenceRepeatedK returns the longest subsequence which repeats at least k times in the string `s`.
// A subsequence means the characters appear in order (but not necessarily contiguously).
func longestSubsequenceRepeatedK(s string, k int) string {
	// Count the frequency of each character in the input string.
	freq := make([]int, 26)
	for _, ch := range s {
		freq[ch-'a']++
	}

	// Filter characters that appear at least `k` times (since any valid subsequence repeated `k` times
	// must have each character appear at least `k` times in total).
	var candidate []byte
	for i := 25; i >= 0; i-- { // Start from 'z' to ensure lexicographical ordering preference.
		if freq[i] >= k {
			candidate = append(candidate, byte('a'+i))
		}
	}

	// Initialize the BFS queue with one-letter candidates.
	q := []string{}
	for _, ch := range candidate {
		q = append(q, string(ch))
	}

	ans := ""
	// Perform BFS to generate and test longer candidate subsequences.
	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		// Update the answer if the current string is longer (favoring lexicographically larger strings because of reverse ordering).
		if len(curr) > len(ans) {
			ans = curr
		}

		// Generate all next possible candidates by appending allowed characters.
		for _, c := range candidate {
			next := curr + string(c)
			// Check if the candidate is a valid subsequence repeated at least `k` times.
			if isKRepeated(s, next, k) {
				q = append(q, next)
			}
		}
	}

	return ans
}

// isKRepeated checks whether the given pattern appears at least `k` times as a subsequence in `s`.
func isKRepeated(s, pattern string, k int) bool {
	i, matched := 0, 0
	for _, c := range s {
		if c == rune(pattern[i]) {
			i++
			// If we've matched the full pattern once.
			if i == len(pattern) {
				i = 0
				matched++
				if matched == k {
					return true
				}
			}
		}
	}
	return false
}
