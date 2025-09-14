import (
	"fmt"
	"strings"
)

// Main spellchecker function
func spellchecker(wordlist []string, queries []string) []string {
	// Define a set of vowels (lowercase only) for easy checking
	vowels := map[rune]bool{
		'a': true, 'e': true, 'i': true, 'o': true, 'u': true,
	}

	// Helper function to normalize a word:
	// 1. Convert to lowercase
	// 2. Replace all vowels with '*'
	normalize := func(word string) string {
		var result []rune
		for _, ch := range word {
			// Convert character to lowercase using bitwise OR (ASCII only)
			lowerChar := ch | 32
			if vowels[lowerChar] {
				result = append(result, '*')
			} else {
				result = append(result, lowerChar)
			}
		}
		return string(result)
	}

	// Map to store exact matches (case-sensitive)
	exactMatch := make(map[string]bool)

	// Map to store case-insensitive matches:
	// key = lowercase word, value = first occurrence in wordlist
	caseInsensitive := make(map[string]string)

	// Map to store vowel-insensitive matches:
	// key = normalized word (lowercase + '*' for vowels), value = first occurrence in wordlist
	vowelInsensitive := make(map[string]string)

	// Step 1: Build the three maps from the wordlist
	for _, word := range wordlist {
		// Add word to exact match set
		exactMatch[word] = true

		// Lowercase version of the word
		lowerWord := strings.ToLower(word)

		// If this lowercase version is not already in the map, add it
		if _, exists := caseInsensitive[lowerWord]; !exists {
			caseInsensitive[lowerWord] = word
		}

		// Normalized version (lowercase + vowels replaced with '*')
		normalizedWord := normalize(word)

		// Add to vowelInsensitive map if not already present
		if _, exists := vowelInsensitive[normalizedWord]; !exists {
			vowelInsensitive[normalizedWord] = word
		}
	}

	// Step 2: Process each query according to priority rules
	result := make([]string, len(queries))

	for i, query := range queries {
		// Rule 1: Exact match (case-sensitive)
		if exactMatch[query] {
			result[i] = query
			continue
		}

		// Lowercase version of the query for further matching
		lowerQuery := strings.ToLower(query)

		// Rule 2: Case-insensitive match
		if word, exists := caseInsensitive[lowerQuery]; exists {
			result[i] = word
			continue
		}

		// Rule 3: Vowel-insensitive match
		normalizedQuery := normalize(query)
		if word, exists := vowelInsensitive[normalizedQuery]; exists {
			result[i] = word
			continue
		}

		// Rule 4: No match found
		result[i] = ""
	}

	// Return the list of corrected words
	return result
}
