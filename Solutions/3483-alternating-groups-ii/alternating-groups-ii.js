/**
 * @param {number[]} colors
 * @param {number} k
 * @return {number}
 */
var numberOfAlternatingGroups = function(colors, k) {
    // Step 1: Extend the array to handle circular sequences
    for (let i = 0; i < k - 1; i++) {
        colors.push(colors[i]);
    }

    const length = colors.length;
    let result = 0;
    
    // Step 2: Initialize the bounds of the sliding window
    let left = 0;
    let right = 1;

    while (right < length) {
        // Step 3: Check if the current color is the same as the last one
        if (colors[right] === colors[right - 1]) {
            // If the pattern breaks, reset the window from the current position
            left = right;
            right++;
            continue;
        }

        // Step 4: Extend the window
        right++;

        // Step 5: Skip counting if the window size is less than k
        if (right - left < k) {
            continue;
        }

        // Step 6: If the window size is exactly k and it's alternating, record it
        result++;
        left++;
    }

    return result;
};
