/**
 * @param {string} word
 * @param {number} k
 * @return {number}
 */
var countOfSubstrings = function(word, k) {
    // Helper function to check if a character is a vowel
    function _isVowel(c) {
        return c === "a" || c === "e" || c === "i" || c === "o" || c === "u";
    }

    let numValidSubstrings = 0;
    let start = 0, end = 0;
    let vowelCount = {}; // Object to keep counts of vowels
    let consonantCount = 0; // Count of consonants
    let nextConsonant = new Array(word.length).fill(0); // Array to compute the index of the next consonant for all indices
    let nextConsonantIndex = word.length;

    // Fill the nextConsonant array in reverse order
    for (let i = word.length - 1; i >= 0; i--) {
        nextConsonant[i] = nextConsonantIndex;
        if (!_isVowel(word[i])) {
            nextConsonantIndex = i;
        }
    }

    // Sliding window logic to find valid substrings
    while (end < word.length) {
        let newLetter = word[end];

        if (_isVowel(newLetter)) {
            vowelCount[newLetter] = (vowelCount[newLetter] || 0) + 1;
        } else {
            consonantCount++;
        }

        // Shrink the window if we have more than `k` consonants
        while (consonantCount > k) {
            let startLetter = word[start];
            if (_isVowel(startLetter)) {
                vowelCount[startLetter]--;
                if (vowelCount[startLetter] === 0) {
                    delete vowelCount[startLetter];
                }
            } else {
                consonantCount--;
            }
            start++;
        }

        // If the window is valid (all vowels and exactly `k` consonants), count valid substrings
        while (start < word.length && Object.keys(vowelCount).length === 5 && consonantCount === k) {
            numValidSubstrings += nextConsonant[end] - end;

            let startLetter = word[start];
            if (_isVowel(startLetter)) {
                vowelCount[startLetter]--;
                if (vowelCount[startLetter] === 0) {
                    delete vowelCount[startLetter];
                }
            } else {
                consonantCount--;
            }
            start++;
        }

        end++;
    }

    return numValidSubstrings;
};

