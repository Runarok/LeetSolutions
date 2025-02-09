/**
 * @param {number[]} nums
 * @return {number}
 */
var maxAdjacentDistance = function(nums) {
    let maxDiff = 0;
    
    // Loop over the array and calculate absolute differences between adjacent elements
    for (let i = 0; i < nums.length; i++) {
        let nextIndex = (i + 1) % nums.length;  // Circular behavior
        let diff = Math.abs(nums[i] - nums[nextIndex]);
        maxDiff = Math.max(maxDiff, diff);
    }
    
    return maxDiff;
};
