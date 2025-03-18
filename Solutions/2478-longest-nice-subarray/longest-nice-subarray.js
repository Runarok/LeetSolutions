/**
 * @param {number[]} nums
 * @return {number}
 */
 
 var longestNiceSubarray = function(nums) {
    let n = nums.length;
    let maxLength = 1;  // A subarray of length 1 is always nice
    let currentBitwiseOR = 0;
    let start = 0;

    // Iterate through the array using the 'end' pointer
    for (let end = 0; end < n; end++) {
        // Check the bitwise OR with the current element
        while ((currentBitwiseOR & nums[end]) !== 0) {
            // Move the 'start' pointer to the right, and update the current OR
            currentBitwiseOR ^= nums[start];
            start++;
        }

        // Add the current element to the bitwise OR
        currentBitwiseOR |= nums[end];
        // Update the maxLength of the nice subarray
        maxLength = Math.max(maxLength, end - start + 1);
    }

    return maxLength;
};
