/**
 * @param {number[]} nums
 * @return {boolean}
 */
var check = function(nums) {
    let dropCount = 0;

    for (let i = 0; i < nums.length; i++) {
        // Check if the current element is greater than the next element
        if (nums[i] > nums[(i + 1) % nums.length]) {
            dropCount++;
        }
        
        // If there is more than one drop, it's not a rotated sorted array
        if (dropCount > 1) {
            return false;
        }
    }

    return true;
};
