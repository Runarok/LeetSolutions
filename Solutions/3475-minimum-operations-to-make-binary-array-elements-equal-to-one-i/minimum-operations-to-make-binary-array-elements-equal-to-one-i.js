/**
 * @param {number[]} nums
 * @return {number}
 */
 
 var minOperations = function(nums) {
    let operations = 0; // Initialize the number of operations to 0
    // Loop through the array up to the third last element
    for (let i = 0; i < nums.length - 2; i++) {
        // If the current element is 0, we need to flip it
        if (nums[i] === 0) {
            // Flip the current element and the next two elements
            nums[i] = 1 - nums[i];
            nums[i + 1] = 1 - nums[i + 1];
            nums[i + 2] = 1 - nums[i + 2];
            // Increment the operation count
            operations++;
        }
    }
    // After the loop, check if there are any 0s left in the array
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) {
            // If a 0 is found, it's impossible to make all elements 1, so return -1
            return -1;
        }
    }
    // Return the total number of operations performed
    return operations;
};
