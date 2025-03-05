/**
 * @param {number} n - The number of minutes after which we need to return the number of colored cells
 * @return {number} - The total number of colored cells after n minutes
 */
var coloredCells = function(n) {
    let numBlueCells = 1; // Initial number of blue cells after the first minute
    let addend = 4; // The number of new cells to color at each subsequent minute

    // Iterate n - 1 times since the first minute is already handled
    while (n - 1) {
        numBlueCells += addend; // Add the new cells to the total count
        addend += 4; // Increase the number of cells added in the next minute by 4
        n -= 1; // Decrease n to track how many minutes remain
    }

    return numBlueCells;
};
