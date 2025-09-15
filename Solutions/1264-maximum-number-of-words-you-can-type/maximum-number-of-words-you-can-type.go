import "strings"

// canBeTypedWords returns the number of words in 'text' that can be fully typed
// using a keyboard with some broken letter keys provided in 'brokenLetters'.
func canBeTypedWords(text string, brokenLetters string) int {
    // Create a map to store broken letters for fast lookup (O(1) per character check)
    broken := make(map[rune]bool)

    // Populate the map with broken letters
    // Each character in brokenLetters is a key in the map
    for _, ch := range brokenLetters {
        broken[ch] = true
    }

    // Counter for words that can be fully typed without any broken letters
    count := 0

    // Split the input text by spaces to get individual words
    // According to the problem statement, words are separated by a single space
    words := strings.Split(text, " ")

    // Iterate through each word
    for _, word := range words {
        // Assume the word can be typed unless a broken letter is found
        canType := true

        // Check each character of the word
        for _, ch := range word {
            // If the character is in the broken set, we can't type this word
            if broken[ch] {
                canType = false
                break // Stop checking further letters in this word
            }
        }

        // If the word passed all checks (no broken letters), increase count
        if canType {
            count++
        }
    }

    // Return the total number of typable words
    return count
}
