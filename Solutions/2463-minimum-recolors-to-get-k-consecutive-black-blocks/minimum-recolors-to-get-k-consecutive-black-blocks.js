/**
 * @param {string} blocks
 * @param {number} k
 * @return {number}
 */
var minimumRecolors = function(blocks, k) {
    let n = blocks.length;
    let minRecolors = Number.MAX_VALUE; // Initialize to a large number.
    
    // Iterate through all possible windows of size k
    for (let i = 0; i <= n - k; i++) {
        let recolors = 0;
        
        // Count the number of 'W' in the current window of size k
        for (let j = i; j < i + k; j++) {
            if (blocks[j] === 'W') {
                recolors++;
            }
        }
        
        // Update the minimum recolors if we found a smaller count of 'W's in this window
        minRecolors = Math.min(minRecolors, recolors);
    }
    
    return minRecolors;
};
