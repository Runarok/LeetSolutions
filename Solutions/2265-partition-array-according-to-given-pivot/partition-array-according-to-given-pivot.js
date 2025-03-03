/**
 * @param {number[]} nums
 * @param {number} pivot
 * @return {number[]}
 */
 
var pivotArray = function(nums, pivot) {
    // Initialize three arrays to hold values less than, equal to, and greater than pivot
    let less = [];
    let equal = [];
    let greater = [];

    // Loop through nums and categorize each element
    for (let num of nums) {
        if (num < pivot) {
            less.push(num); // Elements less than pivot
        } else if (num === pivot) {
            equal.push(num); // Elements equal to pivot
        } else {
            greater.push(num); // Elements greater than pivot
        }
    }

    // Concatenate the arrays to form the result
    return [...less, ...equal, ...greater];
};
