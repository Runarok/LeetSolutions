/**
 * @param {number[][]} grid
 * @return {number}
 */
var countServers = function(grid) {
    let m = grid.length;
    let n = grid[0].length;
    
    // Arrays to count servers in each row and column
    let rowCount = Array(m).fill(0);
    let colCount = Array(n).fill(0);
    
    // Populate rowCount and colCount
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                rowCount[i]++;
                colCount[j]++;
            }
        }
    }
    
    // Now, check how many servers can communicate
    let result = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                // A server can communicate if there are other servers in its row or column
                if (rowCount[i] > 1 || colCount[j] > 1) {
                    result++;
                }
            }
        }
    }
    
    return result;
};
