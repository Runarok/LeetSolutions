function countPalindromicSubsequence(s: string): number {

    // Convert string to array for faster indexed access
    const arr = s.split('');

    let total = 0;

    // Loop over all possible characters 'a'..'z'
    for (let code = 97; code <= 122; code++) {
        const c = String.fromCharCode(code);

        // First position of c
        const i = s.indexOf(c);
        // Last position of c
        const j = s.lastIndexOf(c);

        // Must appear at least twice to form c _ c
        if (i !== -1 && i !== j) {

            // Track which middle characters we have seen between i and j
            // A boolean array of size 26, initially false
            const seen = new Array<boolean>(26).fill(false);

            let count = 0;

            // Walk over the interior range (i+1 ... j-1)
            for (let k = i + 1; k < j; k++) {
                const midChar = arr[k];
                const idx = midChar.charCodeAt(0) - 97; // convert 'a'..'z' → 0..25

                // Each distinct middle character produces one palindrome c x c
                if (!seen[idx]) {
                    seen[idx] = true;
                    count++;
                }
            }

            total += count;
        }
    }

    return total;
}
