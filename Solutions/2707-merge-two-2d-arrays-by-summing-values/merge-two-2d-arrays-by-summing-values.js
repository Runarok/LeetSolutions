/**
 * @param {number[][]} nums1
 * @param {number[][]} nums2
 * @return {number[][]}
 */
var mergeArrays = function(nums1, nums2) {
    // Create a map to hold the result
    let resultMap = new Map();

    // Iterate through the first array and add the values to the map
    for (let [id, value] of nums1) {
        resultMap.set(id, (resultMap.get(id) || 0) + value);
    }

    // Iterate through the second array and add the values to the map
    for (let [id, value] of nums2) {
        resultMap.set(id, (resultMap.get(id) || 0) + value);
    }

    // Convert the map to an array and sort by ID
    let result = Array.from(resultMap.entries()).sort((a, b) => a[0] - b[0]);

    return result;
};
