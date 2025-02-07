/**
 * @param {number} limit
 * @param {number[][]} queries
 * @return {number[]}
 */
var queryResults = function(limit, queries) {
    let ballColors = {}; // To store the color of each ball
    let colorCount = {}; // To track how many balls have each color
    let distinctColorCount = 0; // To track how many distinct colors are there
    let result = [];
    
    // Process each query
    for (let [ball, color] of queries) {
        if (ballColors[ball] !== undefined) {
            // Ball already has a color
            let oldColor = ballColors[ball];
            if (oldColor !== color) {
                // If the color is changing
                // Decrease count for the old color
                colorCount[oldColor]--;
                if (colorCount[oldColor] === 0) {
                    delete colorCount[oldColor]; // Remove color if no balls have it
                    distinctColorCount--;
                }
                
                // Update to the new color
                ballColors[ball] = color;
                if (!colorCount[color]) {
                    colorCount[color] = 0;
                }
                colorCount[color]++;
                if (colorCount[color] === 1) {
                    distinctColorCount++;
                }
            }
        } else {
            // Ball does not have a color, it's being colored for the first time
            ballColors[ball] = color;
            if (!colorCount[color]) {
                colorCount[color] = 0;
            }
            colorCount[color]++;
            if (colorCount[color] === 1) {
                distinctColorCount++;
            }
        }

        // Record the number of distinct colors after this query
        result.push(distinctColorCount);
    }
    
    return result;
};
