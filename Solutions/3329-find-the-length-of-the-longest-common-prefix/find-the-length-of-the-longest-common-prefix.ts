function longestCommonPrefix(arr1: number[], arr2: number[]): number {
    // A Set to store ALL prefixes from arr1
    // Example:
    // If number = 1234
    // Prefixes are:
    // 1
    // 12
    // 123
    // 1234
    const prefixSet = new Set<string>();

    // ---------------------------------------------------
    // STEP 1:
    // Generate every possible prefix from arr1
    // ---------------------------------------------------
    for (const num of arr1) {
        // Convert number to string
        // because prefixes are easier to handle as strings
        const str = num.toString();

        // Build prefixes one by one
        for (let i = 1; i <= str.length; i++) {
            // substring(0, i) gives prefix from start to i
            // Example:
            // str = "1234"
            // i = 2 => "12"
            prefixSet.add(str.substring(0, i));
        }
    }

    // This will store the maximum prefix length found
    let longest = 0;

    // ---------------------------------------------------
    // STEP 2:
    // Check prefixes of every number in arr2
    // ---------------------------------------------------
    for (const num of arr2) {
        const str = num.toString();

        // Generate prefixes for current number
        for (let i = 1; i <= str.length; i++) {
            const prefix = str.substring(0, i);

            // If this prefix exists in arr1 prefixes
            if (prefixSet.has(prefix)) {
                // Update answer with maximum length
                longest = Math.max(longest, i);
            }
        }
    }

    // ---------------------------------------------------
    // STEP 3:
    // Return longest common prefix length
    // ---------------------------------------------------
    return longest;
}