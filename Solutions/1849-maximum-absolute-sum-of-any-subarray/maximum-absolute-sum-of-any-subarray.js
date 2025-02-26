/**
 * @param {number[]} nums
 * @return {number}
 */

var maxAbsoluteSum = function(nums) {
    let maxSum = 0;  // max subarray sum
    let minSum = 0;  // min subarray sum
    let currentMax = 0;
    let currentMin = 0;
    
    for (let num of nums) {
        currentMax = Math.max(num, currentMax + num);  // max sum ending at current position
        currentMin = Math.min(num, currentMin + num);  // min sum ending at current position
        
        maxSum = Math.max(maxSum, currentMax);  // update the max subarray sum
        minSum = Math.min(minSum, currentMin);  // update the min subarray sum
    }
    
    return Math.max(Math.abs(maxSum), Math.abs(minSum));  // return the max of the absolute values
};
