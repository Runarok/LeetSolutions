/**
 * @param {number[]} nums
 * @return {number}
 */

/**
 * @param {number[]} nums
 * @return {number}
 */
var countBadPairs = function(nums) {
    let n = nums.length;
    let diffCount = {};  // To store frequency of each diff[i]
    let badPairs = 0;

    // Step 1: Calculate diff[i] and store frequencies
    for (let i = 0; i < n; i++) {
        let diff = i - nums[i];
        diffCount[diff] = (diffCount[diff] || 0) + 1;
    }

    // Step 2: Calculate good pairs (pairs with the same diff)
    let goodPairs = 0;
    for (let count of Object.values(diffCount)) {
        if (count > 1) {
            goodPairs += count * (count - 1) / 2; // nC2 (combinations of pairs)
        }
    }

    // Step 3: Total pairs - good pairs = bad pairs
    let totalPairs = n * (n - 1) / 2;  // Total possible pairs
    badPairs = totalPairs - goodPairs;

    return badPairs;
};