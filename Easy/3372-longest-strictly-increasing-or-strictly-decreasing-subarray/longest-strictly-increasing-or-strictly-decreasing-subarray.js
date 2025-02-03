/**
 * @param {number[]} nums
 * @return {number}
 */
var longestMonotonicSubarray = function(nums) {
    if (nums.length === 0) return 0;
    
    let maxLength = 1;
    let incLength = 1; // Length of current strictly increasing subsequence
    let decLength = 1; // Length of current strictly decreasing subsequence
    
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > nums[i - 1]) {
            // Continue the increasing subsequence
            incLength++;
            decLength = 1; // Reset the decreasing subsequence
        } else if (nums[i] < nums[i - 1]) {
            // Continue the decreasing subsequence
            decLength++;
            incLength = 1; // Reset the increasing subsequence
        } else {
            // Reset both if numbers are equal
            incLength = 1;
            decLength = 1;
        }
        
        // Update the maximum length of any monotonic subsequence
        maxLength = Math.max(maxLength, incLength, decLength);
    }
    
    return maxLength;
};
