function maxDifference(s: string): number {
    // 1: Start function definition
    // 2: Input string s
    // 3: Initialize frequency map
    const freq: Record<string, number> = {};
    // 4: Loop through each character in s
    for (const char of s) {
        // 5: Check if character already in freq
        // 6: If yes, increment count
        // 7: If no, initialize count to 1
        freq[char] = (freq[char] || 0) + 1;
        // 8: Continue to next character
    }
    // 9: Frequency counting done

    // 10: Prepare arrays to store odd and even frequencies
    const oddFreqs: number[] = [];
    // 11: Initialize oddFreqs as empty array
    const evenFreqs: number[] = [];
    // 12: Initialize evenFreqs as empty array

    // 13: Loop over each character in frequency map
    for (const char in freq) {
        // 14: Access frequency of current character
        const count = freq[char];
        // 15: Check if frequency is odd
        if (count % 2 === 1) {
            // 16: Frequency is odd
            oddFreqs.push(count);
            // 17: Add to oddFreqs array
        } else {
            // 18: Frequency is even
            evenFreqs.push(count);
            // 19: Add to evenFreqs array
        }
        // 20: Move to next character frequency
    }
    // 21: Classification of odd and even frequencies done

    // 22: Initialize maxDiff with very small number
    let maxDiff = -Infinity;
    // 23: Will hold max difference found

    // 24: Loop over all odd frequencies
    for (const odd of oddFreqs) {
        // 25: Loop over all even frequencies
        for (const even of evenFreqs) {
            // 26: Calculate difference odd - even
            const diff = odd - even;
            // 27: Check if this diff is larger than current maxDiff
            if (diff > maxDiff) {
                // 28: Update maxDiff if new max found
                maxDiff = diff;
            }
            // 29: Continue inner loop
        }
        // 30: Continue outer loop
    }
    // 31: Completed comparison of all pairs

    // 32: Return maxDiff found
    return maxDiff;

    // 33: Function end
}
