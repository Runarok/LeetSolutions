func maxFreqSum(s string) int {
    // Define a map to count the frequency of each character
    freq := make(map[rune]int)

    // Loop through the input string and populate the frequency map
    for _, ch := range s {
        freq[ch]++
    }

    // Define a set of vowels for easy lookup
    vowels := map[rune]bool{
        'a': true,
        'e': true,
        'i': true,
        'o': true,
        'u': true,
    }

    // Initialize variables to keep track of max vowel and consonant frequencies
    maxVowelFreq := 0
    maxConsonantFreq := 0

    // Iterate through the frequency map
    for ch, count := range freq {
        if vowels[ch] {
            // If character is a vowel, update maxVowelFreq if needed
            if count > maxVowelFreq {
                maxVowelFreq = count
            }
        } else {
            // If character is a consonant, update maxConsonantFreq if needed
            if count > maxConsonantFreq {
                maxConsonantFreq = count
            }
        }
    }

    // Return the sum of the highest vowel and consonant frequencies
    return maxVowelFreq + maxConsonantFreq
}
