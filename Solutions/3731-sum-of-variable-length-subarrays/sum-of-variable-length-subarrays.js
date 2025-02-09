/**
 * @param {number[]} nums
 * @return {number}
 */
var subarraySum = function(nums) {
    let totalSum = 0;
    let n = nums.length;
    
    // Iterate over each index i
    for (let i = 0; i < n; i++) {
        let start = Math.max(0, i - nums[i]);
        
        // Sum the elements from start to i
        let subarraySum = 0;
        for (let j = start; j <= i; j++) {
            subarraySum += nums[j];
        }
        
        // Add the subarray sum to the total sum
        totalSum += subarraySum;
    }
    
    return totalSum;
};
