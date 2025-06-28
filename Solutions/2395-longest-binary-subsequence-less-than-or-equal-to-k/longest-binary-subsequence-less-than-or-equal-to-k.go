// longestSubsequence returns the length of the longest subsequence of binary string `s`
// such that the binary number it represents is less than or equal to integer `k`.
func longestSubsequence(s string, k int) int {
	sm := 0      // sm stores the integer value of the current subsequence
	cnt := 0     // cnt counts the number of characters included in the subsequence
	bitLimit := bits.Len(uint(k)) // bitLimit is the number of bits required to represent k

	// We iterate from right to left (least significant to most significant bit)
	for i := 0; i < len(s); i++ {
		ch := s[len(s)-1-i] // Get character from end (reverse iteration)

		if ch == '1' {
			// We can only consider '1's if their contribution doesn't make the value exceed k
			// and they are within the bit length limit
			if i < bitLimit && sm+(1<<i) <= k {
				sm += 1 << i  // Add 2^i to the current sum
				cnt++         // Include this character in the subsequence
			}
			// If including this '1' exceeds the value or bit limit, we skip it
		} else {
			// '0's don't increase the value, so we can always include them
			cnt++
		}
	}

	return cnt
}