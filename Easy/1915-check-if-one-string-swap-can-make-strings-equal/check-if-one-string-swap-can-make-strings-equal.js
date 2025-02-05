/**
 * @param {string} s1
 * @param {string} s2
 * @return {boolean}
 */
var areAlmostEqual = function(s1, s2) {
    // If the strings are already equal, no swap is needed
    if (s1 === s2) return true;
    
    let diff = [];
    
    // Find the positions where the characters differ
    for (let i = 0; i < s1.length; i++) {
        if (s1[i] !== s2[i]) {
            diff.push(i);
        }
    }
    
    // If there are not exactly two differing positions, return false
    if (diff.length !== 2) return false;
    
    // Check if swapping these two differing characters will make the strings equal
    let [i, j] = diff;
    return s1[i] === s2[j] && s1[j] === s2[i];
};
