/**
 * @param {string} tiles
 * @return {number}
 */
var numTilePossibilities = function(tiles) {
    let result = new Set();
    
    // Helper function for backtracking
    function backtrack(tiles, path, count) {
        if (path.length > 0) {
            result.add(path); // Add current sequence to the result set
        }
        
        // Explore all characters in the tiles
        for (let i = 0; i < tiles.length; i++) {
            if (count[tiles[i]] > 0) { // If the character can be used
                count[tiles[i]]--; // Use the character
                backtrack(tiles, path + tiles[i], count); // Recurse with the updated path
                count[tiles[i]]++; // Backtrack, put the character back
            }
        }
    }

    // Count the occurrences of each letter
    let count = {};
    for (let tile of tiles) {
        count[tile] = (count[tile] || 0) + 1;
    }
    
    // Start backtracking
    backtrack(tiles, "", count);

    // Return the number of unique sequences
    return result.size;
};
