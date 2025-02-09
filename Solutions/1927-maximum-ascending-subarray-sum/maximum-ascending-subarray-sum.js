/**
 * @param {number[]} nums
 * @return {number}
 */
var maxAscendingSum = function(nums) {
    // Initialize two variables:
    // max_sum will store the largest sum of any ascending subarray encountered
    // current_sum will store the sum of the current ascending subarray
    let max_sum = 0;
    let current_sum = 0;

    // Loop through each number in the nums array
    for (let i = 0; i < nums.length; i++) {
        // If we are at the second element or later (i > 0), check if the current element is greater than the previous one
        // This checks if the subarray is still ascending
        if (i > 0 && nums[i] > nums[i - 1]) {
            // If ascending, add the current number to current_sum
            current_sum += nums[i];
        } else {
            // If the sequence is not ascending, we compare current_sum with max_sum and update max_sum if needed
            max_sum = Math.max(max_sum, current_sum);
            // Reset current_sum to the current element, starting a new subarray
            current_sum = nums[i];
        }
    }

    // After the loop ends, we must check for the last subarray (it might be the largest)
    max_sum = Math.max(max_sum, current_sum);

    // Return the largest sum of any ascending subarray
    return max_sum;
};
