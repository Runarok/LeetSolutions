/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
    let map = new Map();  // Create a map to store numbers and their indices
    
    // Iterate through the array
    for (let i = 0; i < nums.length; i++) {
        let complement = target - nums[i];  // Calculate the complement
        
        // Check if the complement exists in the map
        if (map.has(complement)) {
            // Return the indices of the current number and the complement
            return [map.get(complement), i];
        }
        
        // Store the current number and its index in the map
        map.set(nums[i], i);
    }
};
