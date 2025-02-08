/**
 * @param {string} s
 * @return {number}
 */
var maxScore = function(s) {
    let n = s.length;
    let left_zeros = 0;
    let right_ones = 0;

    // Count the total number of ones in the string
    for (let i = 0; i < n; i++) {
        if (s[i] === '1') {
            right_ones++;
        }
    }

    let maxScore = 0;

    // Iterate through possible splits (i from 1 to n-1)
    for (let i = 0; i < n - 1; i++) {
        if (s[i] === '0') {
            left_zeros++;
        }
        if (s[i] === '1') {
            right_ones--;
        }

        // Calculate the score for the current split
        let score = left_zeros + right_ones;
        maxScore = Math.max(maxScore, score);
    }

    return maxScore;
};

