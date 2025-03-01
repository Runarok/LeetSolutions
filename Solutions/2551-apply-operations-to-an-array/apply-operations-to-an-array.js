/**
 * @param {number[]} nums
 * @return {number[]}
 */
var applyOperations = function(nums) {
    // First, apply the operations on the array
    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === nums[i + 1]) {
            nums[i] *= 2;  // Double the current element
            nums[i + 1] = 0;  // Set the next element to 0
        }
    }

    // Second, shift all zeros to the end
    let index = 0; // Pointer to the position of the next non-zero element
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] !== 0) {
            nums[index] = nums[i]; // Place non-zero element at the 'index' position
            if (index !== i) nums[i] = 0; // Set current position to zero if it's moved
            index++;
        }
    }

    return nums;
};
