function isMatch(s: string, p: string): boolean {
    // Pointers for s and p
    let i = 0; // index in s
    let j = 0; // index in p

    // Variables to remember the position of last '*' in p
    let starIdx = -1;
    let iIdx = -1; // index in s where we start after last '*'

    while (i < s.length) {
        // Case 1: current characters match or pattern is '?'
        if (j < p.length && (p[j] === '?' || p[j] === s[i])) {
            i++;
            j++;
        }
        // Case 2: pattern character is '*'
        else if (j < p.length && p[j] === '*') {
            starIdx = j;   // remember position of '*'
            iIdx = i;      // remember index in s at which '*' matches
            j++;           // move pattern pointer past '*'
        }
        // Case 3: mismatch but there was a previous '*'
        else if (starIdx !== -1) {
            // Backtrack: assume '*' matches one more character
            j = starIdx + 1;
            iIdx++;
            i = iIdx;
        }
        // Case 4: mismatch and no '*' to backtrack
        else {
            return false;
        }
    }

    // After finishing s, check remaining characters in p
    while (j < p.length && p[j] === '*') {
        j++;
    }

    // Match succeeds if we consumed entire pattern
    return j === p.length;
}
