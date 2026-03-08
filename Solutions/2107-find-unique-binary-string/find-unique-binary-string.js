/**
 * @param {string[]} nums
 * @return {string}
 */
var findDifferentBinaryString = function(nums) {
    let n = nums.length;
    let result = '';
    
    // Construct the result string by flipping the diagonal elements
    for (let i = 0; i < n; i++) {
        result += nums[i][i] === '0' ? '1' : '0';
    }
    
    return result;
};
