function stringMatching(words: string[]): string[] {
    // This array will hold the words that are substrings of other words
    const result: string[] = [];

    // Loop through each word in the array as the candidate substring
    for (let i = 0; i < words.length; i++) {
        const currentWord = words[i];

        // Check against every other word in the array
        for (let j = 0; j < words.length; j++) {
            // Skip comparing the word with itself
            if (i === j) continue;

            const otherWord = words[j];

            // Check if currentWord is a substring of otherWord
            if (otherWord.includes(currentWord)) {
                // If yes, add currentWord to result
                result.push(currentWord);
                // No need to check other words once found
                break;
            }
        }
    }

    // Return all words that are substrings of another word
    return result;
}
