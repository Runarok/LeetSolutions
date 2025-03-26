/**
 * @param {number[][]} grid
 * @param {number} x
 * @return {number}
 */

var minOperations = function(grid, x) {
    // Flatten the grid into a single array
    let nums_array = [];
    for (let row of grid) {
        for (let num of row) {
            nums_array.push(num);
        }
    }

    // Check if all elements have the same remainder when divided by x
    let remainder = nums_array[0] % x;
    for (let num of nums_array) {
        if (num % x !== remainder) {
            return -1; // Not possible to make all numbers equal
        }
    }

    // Sort the array to find the median
    nums_array.sort((a, b) => a - b);
    let n = nums_array.length;
    let median = nums_array[Math.floor(n / 2)];

    // Calculate the total number of operations to make all elements equal to the median
    let operations = 0;
    for (let num of nums_array) {
        operations += Math.abs(num - median) / x;
    }

    return operations;
};
