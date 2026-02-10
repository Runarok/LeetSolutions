/**
 * @param {number[]} nums
 * @return {number}
 */
var longestBalanced = function(nums) {

    // Stores the maximum length of a balanced subarray
    let maxLen = 0;

    // Length of the input array
    const n = nums.length;

    // Choose starting index of subarray
    for (let i = 0; i < n; i++) {

        // Set to store distinct even numbers
        const evenSet = new Set();

        // Set to store distinct odd numbers
        const oddSet = new Set();

        // Extend subarray from i to j
        for (let j = i; j < n; j++) {

            // Check if current number is even or odd
            if (nums[j] % 2 === 0) {
                evenSet.add(nums[j]);
            } else {
                oddSet.add(nums[j]);
            }

            // If distinct evens and odds count are equal,
            // the subarray [i...j] is balanced
            if (evenSet.size === oddSet.size) {
                maxLen = Math.max(maxLen, j - i + 1);
            }
        }
    }

    // Return the longest balanced subarray length
    return maxLen;
};
