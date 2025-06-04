function prefixCount(words: string[], pref: string): number {
    // Initialize a counter to keep track of strings with the given prefix
    let count = 0;

    // Loop through each word in the array
    for (const word of words) {
        // Check if the current word starts with the prefix 'pref'
        // startsWith is a built-in method that returns true if the string begins with the specified substring
        if (word.startsWith(pref)) {
            // Increment the count if the prefix matches
            count++;
        }
    }

    // Return the total count of words that start with 'pref'
    return count;
}
