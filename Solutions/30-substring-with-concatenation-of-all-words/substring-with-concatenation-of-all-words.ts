function findSubstring(s: string, words: string[]): number[] {
    const result: number[] = [];

    // Edge cases
    if (words.length === 0 || s.length === 0) return result;

    const wordLen = words[0].length;       // Length of each word
    const wordCount = words.length;        // Number of words
    const totalLen = wordLen * wordCount;  // Length of concatenated substring

    // If s is shorter than total needed length, no solution
    if (s.length < totalLen) return result;

    // ----------------------------------------------------
    // Build frequency map for words
    // Example: ["foo", "bar", "foo"]
    // => { foo: 2, bar: 1 }
    // ----------------------------------------------------
    const freq = new Map<string, number>();
    for (const w of words) {
        freq.set(w, (freq.get(w) || 0) + 1);
    }

    // ----------------------------------------------------
    // We run wordLen independent sliding windows
    // This ensures alignment with word boundaries
    // ----------------------------------------------------
    for (let start = 0; start < wordLen; start++) {

        let left = start;                       // Left boundary of window
        let count = 0;                          // Number of valid words matched
        const seen = new Map<string, number>(); // Word counts in current window

        // Move right pointer in steps of wordLen
        for (let right = start; right + wordLen <= s.length; right += wordLen) {

            // Extract current word
            const word = s.substring(right, right + wordLen);

            // ------------------------------------------------
            // Case 1: Word is part of `words`
            // ------------------------------------------------
            if (freq.has(word)) {
                seen.set(word, (seen.get(word) || 0) + 1);
                count++;

                // ------------------------------------------------
                // If word appears too many times, shrink window
                // from the left until valid again
                // ------------------------------------------------
                while (seen.get(word)! > freq.get(word)!) {
                    const leftWord = s.substring(left, left + wordLen);
                    seen.set(leftWord, seen.get(leftWord)! - 1);
                    left += wordLen;
                    count--;
                }

                // ------------------------------------------------
                // If we matched exactly wordCount words
                // → record starting index
                // ------------------------------------------------
                if (count === wordCount) {
                    result.push(left);

                    // Move window forward by one word
                    const leftWord = s.substring(left, left + wordLen);
                    seen.set(leftWord, seen.get(leftWord)! - 1);
                    left += wordLen;
                    count--;
                }

            } 
            // ------------------------------------------------
            // Case 2: Word not in `words`
            // Reset window completely
            // ------------------------------------------------
            else {
                seen.clear();
                count = 0;
                left = right + wordLen;
            }
        }
    }

    return result;
}
