/**
 * @param {number[]} nums
 * @return {number}
 */
var minimumIndex = function(nums) {
    let firstMap = new Map();
    let secondMap = new Map();
    let n = nums.length;

    // Step 1: Initialize the secondMap with all elements in nums
    for (let num of nums) {
        secondMap.set(num, (secondMap.get(num) || 0) + 1);
    }

    // Step 2: Iterate through the array and find a valid split
    for (let index = 0; index < n; index++) {
        let num = nums[index];

        // Update the secondMap (suffix) and firstMap (prefix)
        secondMap.set(num, secondMap.get(num) - 1);
        firstMap.set(num, (firstMap.get(num) || 0) + 1);

        // Check if current split is valid
        if (
            firstMap.get(num) * 2 > index + 1 &&
            secondMap.get(num) * 2 > n - index - 1
        ) {
            return index;
        }
    }

    // No valid split exists
    return -1;
};
