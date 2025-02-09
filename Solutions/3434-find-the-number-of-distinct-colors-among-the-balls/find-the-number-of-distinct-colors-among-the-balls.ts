function queryResults(limit: number, queries: number[][]): number[] {
    let ballColors: { [key: number]: number } = {};  // Ball -> Color
    let colorCount: { [key: number]: number } = {};  // Color -> Count of Balls
    let distinctColorCount = 0; // Number of distinct colors
    let result: number[] = [];

    for (let [ball, color] of queries) {
        if (ballColors[ball] !== undefined) {
            // Ball already has a color
            let oldColor = ballColors[ball];
            if (oldColor !== color) {
                // The color is changing
                // Decrease count for the old color
                colorCount[oldColor]--;
                if (colorCount[oldColor] === 0) {
                    delete colorCount[oldColor]; // Remove old color if no balls have it
                    distinctColorCount--;
                }

                // Update to the new color
                ballColors[ball] = color;
                if (colorCount[color] === undefined) {
                    colorCount[color] = 0;
                }
                colorCount[color]++;
                if (colorCount[color] === 1) {
                    distinctColorCount++;
                }
            }
        } else {
            // Ball does not have a color (it's being colored for the first time)
            ballColors[ball] = color;
            if (colorCount[color] === undefined) {
                colorCount[color] = 0;
            }
            colorCount[color]++;
            if (colorCount[color] === 1) {
                distinctColorCount++;
            }
        }

        // Store the number of distinct colors after this query
        result.push(distinctColorCount);
    }

    return result;
}
