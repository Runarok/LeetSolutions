function numOfStrings(patterns: string[], word: string): number {
    // Variable to count how many patterns are found in the word
    let count = 0;

    // Loop through every string in the patterns array
    for (let i = 0; i < patterns.length; i++) {

        // Check if the current pattern exists as a substring in word
        if (word.includes(patterns[i])) {

            // If it exists, increase the count
            count++;
        }
    }

    // Return the total number of matching patterns
    return count;
}