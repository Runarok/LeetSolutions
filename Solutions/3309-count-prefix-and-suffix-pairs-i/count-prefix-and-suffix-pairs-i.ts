function countPrefixSuffixPairs(words: string[]): number {
    // Helper function to determine if str1 is both a prefix and suffix of str2
    function isPrefixAndSuffix(str1: string, str2: string): boolean {
        // If str1 is longer than str2, it cannot be a prefix or suffix
        if (str1.length > str2.length) {
            // Early exit for efficiency
            return false;
        }

        // Check if str2 starts with str1
        // The startsWith method returns true if the string begins with the specified substring
        const isPrefix = str2.startsWith(str1);

        // Check if str2 ends with str1
        // The endsWith method returns true if the string ends with the specified substring
        const isSuffix = str2.endsWith(str1);

        // Return true only if both prefix and suffix conditions are met
        return isPrefix && isSuffix;
    }

    // Initialize a counter to zero to keep track of valid pairs (i, j)
    let count = 0;

    // Get the total number of words in the input array
    const n = words.length;

    // Loop over the array with index i from 0 to n-2
    // We stop at n-2 because j must always be greater than i
    for (let i = 0; i < n - 1; i++) {
        // Inner loop starts from i + 1 to ensure i < j
        for (let j = i + 1; j < n; j++) {
            // For the current pair (i, j), check if words[i] is both prefix and suffix of words[j]
            if (isPrefixAndSuffix(words[i], words[j])) {
                // If condition holds, increment our count of valid pairs
                count++;
            }
        }
    }

    // After checking all pairs, return the total count found
    return count;
}
