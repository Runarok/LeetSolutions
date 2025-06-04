function answerString(word: string, numFriends: number): string {
    // If there is only one friend, simply return the original word
    // because no substring manipulation is needed.
    if (numFriends === 1) {
        return word;
    }

    // Get the length of the input word to use for slicing substrings
    const n = word.length;

    // Initialize the result string to an empty string.
    // We'll update this as we find lexicographically larger substrings.
    let res = "";

    // Iterate over each possible starting index of the substring within the word.
    // The upper bound is 'n' because substrings must start within the string.
    for (let i = 0; i < n; i++) {
        // Calculate the end index for the substring:
        // It is the minimum between:
        // 1) The start index plus the substring length (which is n - numFriends + 1)
        // 2) The length of the string 'n' (to avoid going out of bounds)
        //
        // The substring length formula comes from the problem context:
        // The substring length depends on the number of friends, presumably
        // to simulate some splitting logic.
        const s = word.substring(i, Math.min(i + n - numFriends + 1, n));

        // Compare the current substring lexicographically to the stored result.
        // If the current substring is greater (comes later alphabetically),
        // update 'res' to this substring.
        if (s > res) {
            res = s;
        }
    }

    // After checking all possible substrings, return the lexicographically
    // largest substring found.
    return res;
}
