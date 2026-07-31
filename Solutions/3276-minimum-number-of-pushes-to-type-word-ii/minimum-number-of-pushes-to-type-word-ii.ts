function minimumPushes(word: string): number {
    // Frequency array for all 26 lowercase letters
    const freq = new Array(26).fill(0);

    // Count how many times each character appears
    for (const ch of word) {
        freq[ch.charCodeAt(0) - 97]++;
    }

    // Sort frequencies in descending order
    // Most frequent letters should get the cheapest positions
    freq.sort((a, b) => b - a);

    let pushes = 0;

    // Go through the sorted frequencies
    for (let i = 0; i < 26; i++) {

        // If frequency becomes 0, there are no more letters
        if (freq[i] === 0) break;

        // Every group of 8 letters has the same push cost
        //
        // i = 0..7   -> cost = 1
        // i = 8..15  -> cost = 2
        // i = 16..23 -> cost = 3
        // i = 24..25 -> cost = 4
        const cost = Math.floor(i / 8) + 1;

        // Total contribution of this character
        pushes += freq[i] * cost;
    }

    return pushes;
}