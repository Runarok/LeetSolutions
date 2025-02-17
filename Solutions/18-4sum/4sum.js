/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[][]}
 */
var fourSum = function(nums, target) {
    // Sort the array to make it easier to avoid duplicates and apply the two-pointer approach
    nums.sort((a, b) => a - b);
    let result = [];
    
    // Loop through the array with the first pointer
    for (let i = 0; i < nums.length - 3; i++) {
        // Skip duplicates for the first pointer
        if (i > 0 && nums[i] === nums[i - 1]) continue;

        // Loop through the array with the second pointer
        for (let j = i + 1; j < nums.length - 2; j++) {
            // Skip duplicates for the second pointer
            if (j > i + 1 && nums[j] === nums[j - 1]) continue;

            // Two-pointer approach to find the other two numbers
            let left = j + 1;
            let right = nums.length - 1;
            
            while (left < right) {
                let sum = nums[i] + nums[j] + nums[left] + nums[right];

                if (sum === target) {
                    result.push([nums[i], nums[j], nums[left], nums[right]]);
                    // Skip duplicates for the third pointer
                    while (left < right && nums[left] === nums[left + 1]) left++;
                    // Skip duplicates for the fourth pointer
                    while (left < right && nums[right] === nums[right - 1]) right--;
                    left++;
                    right--;
                } else if (sum < target) {
                    left++;
                } else {
                    right--;
                }
            }
        }
    }

    return result;
};
