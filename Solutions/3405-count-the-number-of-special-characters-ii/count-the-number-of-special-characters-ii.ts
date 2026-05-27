function numberOfSpecialChars(word: string): number {
    // ------------------------------------------------------------
    // We need to count letters that are "special"
    //
    // A letter is special if:
    // 1. It appears in lowercase
    // 2. It appears in uppercase
    // 3. EVERY lowercase occurrence comes BEFORE
    //    the FIRST uppercase occurrence
    //
    // Example:
    // "aaAbcBC"
    //
    // 'a':
    // lowercase positions -> 0,1
    // uppercase position  -> 2
    // all lowercase are before uppercase -> SPECIAL
    //
    // ------------------------------------------------------------


    // ------------------------------------------------------------
    // Store:
    //
    // lastLower[i]
    // = last position where lowercase letter appeared
    //
    // firstUpper[i]
    // = first position where uppercase letter appeared
    //
    // index:
    // 0 -> a/A
    // 1 -> b/B
    // ...
    // 25 -> z/Z
    // ------------------------------------------------------------

    const lastLower = new Array(26).fill(-1);
    const firstUpper = new Array(26).fill(Infinity);


    // ------------------------------------------------------------
    // Traverse the string once
    // ------------------------------------------------------------
    for (let i = 0; i < word.length; i++) {

        // current character
        const ch = word[i];

        // --------------------------------------------------------
        // Check if lowercase
        // --------------------------------------------------------
        if (ch >= 'a' && ch <= 'z') {

            // Convert char -> index
            // Example:
            // 'a' -> 0
            // 'b' -> 1
            //
            // charCodeAt(0) gives ASCII code
            // ----------------------------------------------------
            const idx = ch.charCodeAt(0) - 'a'.charCodeAt(0);

            // Store latest lowercase position
            lastLower[idx] = i;
        }

        // --------------------------------------------------------
        // Otherwise uppercase
        // --------------------------------------------------------
        else {

            // Convert uppercase to index
            // 'A' -> 0
            // 'B' -> 1
            // ----------------------------------------------------
            const idx = ch.charCodeAt(0) - 'A'.charCodeAt(0);

            // Store FIRST uppercase position only
            // Math.min keeps earliest index
            // ----------------------------------------------------
            firstUpper[idx] = Math.min(firstUpper[idx], i);
        }
    }


    // ------------------------------------------------------------
    // Count special letters
    // ------------------------------------------------------------
    let count = 0;


    // ------------------------------------------------------------
    // Check every letter from a-z
    // ------------------------------------------------------------
    for (let i = 0; i < 26; i++) {

        // --------------------------------------------------------
        // Conditions:
        //
        // lastLower[i] !== -1
        // => lowercase exists
        //
        // firstUpper[i] !== Infinity
        // => uppercase exists
        //
        // lastLower[i] < firstUpper[i]
        // => ALL lowercase occur before FIRST uppercase
        // --------------------------------------------------------
        if (
            lastLower[i] !== -1 &&
            firstUpper[i] !== Infinity &&
            lastLower[i] < firstUpper[i]
        ) {
            count++;
        }
    }


    // ------------------------------------------------------------
    // Return final answer
    // ------------------------------------------------------------
    return count;
}