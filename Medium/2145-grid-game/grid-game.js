/**
 * @param {number[][]} grid
 * @return {number}
 */
var gridGame = function(grid) {
    let firstRowSum = grid[0].reduce((acc, curr) => acc + curr, 0);
    let secondRowSum = 0;
    let minimumSum = Infinity;
    
    for (let turnIndex = 0; turnIndex < grid[0].length; turnIndex++) {
        firstRowSum -= grid[0][turnIndex];
        minimumSum = Math.min(minimumSum, Math.max(firstRowSum, secondRowSum));
        secondRowSum += grid[1][turnIndex];
    }
    
    return minimumSum;
};
