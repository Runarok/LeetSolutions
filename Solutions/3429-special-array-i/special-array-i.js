/**
 * @param {number[]} nums
 * @return {boolean}
 */
var isArraySpecial = function(nums) {
    for (let i = 0; i < nums.length - 1; i++) {
        // Check if adjacent elements have the same parity
        if ((nums[i] % 2) === (nums[i + 1] % 2)) {
            return false;  // Same parity, so return false
        }
    }
    return true;  // All adjacent pairs have different parity
};
