/**
 * @param {number[]} nums
 * @return {boolean}
 */
var divideArray = function(nums) {
    // Step 1: Create a frequency map to count occurrences of each number
    const freqMap = {};
    
    // Step 2: Iterate through the array and update the frequency map
    for (let num of nums) {
        freqMap[num] = (freqMap[num] || 0) + 1;
    }
    
    // Step 3: Check if each number appears an even number of times
    for (let count of Object.values(freqMap)) {
        if (count % 2 !== 0) {
            return false;  // If any count is odd, return false
        }
    }
    
    // Step 4: If all counts are even, return true
    return true;
};
