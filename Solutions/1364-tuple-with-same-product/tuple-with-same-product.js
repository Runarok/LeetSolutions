/**
 * @param {number[]} nums
 * @return {number}
 */

var tupleSameProduct = function(nums) {
    const productMap = new Map();
    let count = 0;
    
    // Generate all pairs (a, b) and store their product in productMap
    for (let i = 0; i < nums.length; i++) {
        for (let j = i + 1; j < nums.length; j++) {
            const product = nums[i] * nums[j];
            if (productMap.has(product)) {
                productMap.set(product, productMap.get(product) + 1);
            } else {
                productMap.set(product, 1);
            }
        }
    }
    
    // Count how many valid tuples (a, b, c, d) we can form
    for (let countPairs of productMap.values()) {
        // If we have 'k' pairs for the same product, we can form k * (k - 1) / 2 valid tuples
        if (countPairs > 1) {
            count += (countPairs * (countPairs - 1)) / 2;
        }
    }
    
    // Since each tuple (a, b, c, d) is counted 8 times (permutations of (a, b) and (c, d)),
    // divide the total count by 8.
    return count * 8;
};
