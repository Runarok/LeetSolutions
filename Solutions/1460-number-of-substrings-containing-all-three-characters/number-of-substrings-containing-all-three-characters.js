/**
 * @param {string} s
 * @return {number}
 */

var numberOfSubstrings = function(s) {
    let count = 0;
    let freq = { 'a': 0, 'b': 0, 'c': 0 };
    let start = 0;

    // Iterate over the string with the end pointer
    for (let end = 0; end < s.length; end++) {
        // Increment the frequency of the current character
        freq[s[end]]++;

        // Check if all characters 'a', 'b', and 'c' are present
        while (freq['a'] > 0 && freq['b'] > 0 && freq['c'] > 0) {
            // All substrings from start to end are valid
            count += s.length - end;
            
            // Shrink the window from the left
            freq[s[start]]--;
            start++;
        }
    }

    return count;
};
