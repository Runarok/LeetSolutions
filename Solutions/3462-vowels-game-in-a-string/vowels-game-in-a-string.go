func doesAliceWin(s string) bool {
    vowels := map[byte]bool{
        'a': true, 'e': true, 'i': true, 'o': true, 'u': true,
    }

    // Prefix parity count
    // count[0] = number of prefixes with even number of vowels
    // count[1] = number of prefixes with odd number of vowels
    count := [2]int{1, 0} // Start with even prefix (0 vowels)
    
    vowelCount := 0 // total number of vowels so far
    for i := 0; i < len(s); i++ {
        if vowels[s[i]] {
            vowelCount++
        }
        parity := vowelCount % 2
        count[parity]++
    }

    // Total number of substrings with odd number of vowels:
    // We choose two prefixes with different parity
    // (even, odd) and (odd, even) → count[0] * count[1]
    totalOddVowelSubstrings := count[0] * count[1]

    // If there's at least one odd vowel substring, Alice can make a move
    return totalOddVowelSubstrings > 0
}
