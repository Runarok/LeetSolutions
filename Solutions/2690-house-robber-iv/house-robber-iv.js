/**
 * @param {number[]} nums
 * @param {number} k
 * @return {number}
 */

var minCapability = function(nums, k) {
    // Helper function to check if we can rob at least `k` houses with the given max capability
    const canRobAtLeastK = (maxCapability) => {
        let count = 0;
        let i = 0;
        while (i < nums.length) {
            if (nums[i] <= maxCapability) {
                count++;
                i += 2; // skip the next house since adjacent houses cannot be robbed
            } else {
                i++;
            }
            if (count >= k) return true;
        }
        return false;
    };

    // Binary search over the capability
    let left = Math.min(...nums);
    let right = Math.max(...nums);
    let result = right;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        
        if (canRobAtLeastK(mid)) {
            result = mid;  // We can rob at least k houses with this capability
            right = mid - 1;  // Try to minimize the capability
        } else {
            left = mid + 1;  // Increase the capability
        }
    }

    return result;
};
