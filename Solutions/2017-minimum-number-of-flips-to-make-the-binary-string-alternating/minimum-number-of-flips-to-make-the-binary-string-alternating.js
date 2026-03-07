/**
 * @param {string} s
 * @return {number}
 */

var minFlips = function(s) {
    const n = s.length;
    // Duplicate the string to handle rotations easily.
    // For example, s = "111000" becomes t = "111000111000"
    const t = s + s;

    let mis0 = 0; // Number of mismatches if we want the pattern to start with '0'
    let ans = n;  // Initialize answer to maximum possible flips (all characters might need flipping)

    // Iterate over the extended string
    for (let i = 0; i < 2 * n; i++) {

        // Determine the expected character in alternating pattern starting with '0'
        const expected = (i % 2 === 0) ? '0' : '1';

        // Count mismatch: if current character does not match expected, increment mis0
        if (t[i] !== expected) mis0++;

        // Maintain a sliding window of size n
        if (i >= n) {
            const left = i - n; // Index that exits the sliding window
            // Determine what the character at the left index should have been
            const expLeft = (left % 2 === 0) ? '0' : '1';
            // If the exiting character was a mismatch, decrement mis0
            if (t[left] !== expLeft) mis0--;
        }

        // Once the window reaches size n, calculate flips needed
        if (i >= n - 1) {
            // mis1 is flips needed if pattern starts with '1' instead of '0'
            const mis1 = n - mis0;
            // Take the minimum flips between starting with '0' or '1'
            ans = Math.min(ans, Math.min(mis0, mis1));
        }
    }

    return ans; // Return the minimum number of flips required
};