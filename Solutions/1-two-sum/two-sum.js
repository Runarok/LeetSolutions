/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
    // Step 1: We will return the result as an array
    let result = new Array(2);  // Array of size 2 to store indices
    
    // Step 2: Brute force checking to find the solution
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            if (nums[i] + nums[j] === target) {
                result[0] = i;
                result[1] = j;
                return result;
            }
        }
    }

    return null;  // If no solution is found, return null
};
