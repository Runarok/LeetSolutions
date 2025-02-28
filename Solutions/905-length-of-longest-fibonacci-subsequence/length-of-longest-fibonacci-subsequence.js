/**
 * @param {number[]} arr
 * @return {number}
 */

var lenLongestFibSubseq = function(arr) {
    const n = arr.length;
    const indexMap = new Map();
    const dp = new Map(); // dp is a map of map

    // Fill indexMap with element values and their indices
    for (let i = 0; i < n; i++) {
        indexMap.set(arr[i], i);
    }

    let maxLen = 0;

    // Iterate over all pairs (i, j) where i < j
    for (let j = 1; j < n; j++) {
        for (let i = 0; i < j; i++) {
            // Calculate the potential previous element in the sequence
            const prev = arr[j] - arr[i];

            // Check if prev exists in the array and is before i
            if (prev < arr[i] && indexMap.has(prev)) {
                const k = indexMap.get(prev);
                // If dp[k][i] exists, the new subsequence length can be extended
                const len = dp.has(k) && dp.get(k).has(i) ? dp.get(k).get(i) + 1 : 3;
                if (!dp.has(i)) dp.set(i, new Map());
                dp.get(i).set(j, len);
                maxLen = Math.max(maxLen, len);
            }
        }
    }

    return maxLen >= 3 ? maxLen : 0;
};
