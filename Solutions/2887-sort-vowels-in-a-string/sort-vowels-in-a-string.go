func sortVowels(s string) string {
	// Helper function to check if a character is a vowel (both lowercase and uppercase)
	isVowel := func(c byte) bool {
		return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
			c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U'
	}

	// Convert the input string to a byte slice since strings are immutable in Go
	bytes := []byte(s)

	// Step 1: Collect all vowels from the string
	var vowels []byte
	for i := 0; i < len(bytes); i++ {
		if isVowel(bytes[i]) {
			vowels = append(vowels, bytes[i])
		}
	}

	// Step 2: Sort the collected vowels by their ASCII values
	sort.Slice(vowels, func(i, j int) bool {
		return vowels[i] < vowels[j]
	})

	// Step 3: Replace vowels in the original string with the sorted ones
	vowelIndex := 0 // pointer to track the index in the sorted vowels slice
	for i := 0; i < len(bytes); i++ {
		if isVowel(bytes[i]) {
			// Replace current vowel with the next vowel from the sorted list
			bytes[i] = vowels[vowelIndex]
			vowelIndex++
		}
	}

	// Convert the byte slice back to string and return the result
	return string(bytes)
}
