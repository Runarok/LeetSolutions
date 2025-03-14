/**
 * @param {number[]} candies
 * @param {number} k
 * @return {number}
 */

var maximumCandies = function(candies, k) {
    // Function to check if we can allocate `x` candies to `k` children
    function canAllocate(x) {
        let totalChildren = 0;
        for (let i = 0; i < candies.length; i++) {
            totalChildren += Math.floor(candies[i] / x);
        }
        return totalChildren >= k;
    }
    
    let low = 0, high = Math.max(...candies);
    let result = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        
        if (canAllocate(mid)) {
            result = mid;  // If it's possible to allocate `mid` candies, update result
            low = mid + 1; // Try for a larger value
        } else {
            high = mid - 1; // Try for a smaller value
        }
    }

    return result;
};
