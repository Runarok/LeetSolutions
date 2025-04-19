function countFairPairs(nums: number[], lower: number, upper: number): number {
    // Step 1: Sort the array to apply two-pointer and binary search techniques efficiently
    nums.sort((a, b) => a - b);
    
    let count = 0;  // Initialize the count of valid pairs
    const n = nums.length;  // Get the length of the array

    // Step 2: Iterate through each element in the array using the first pointer `i`
    for (let i = 0; i < n - 1; i++) {
        let left = i + 1, right = n - 1;  // Initialize two pointers: `left` starts just after `i`, `right` starts at the end of the array
        
        // Binary search for the lower bound:
        // Find the smallest index `left` such that `nums[i] + nums[left] >= lower`
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);  // Find the middle index
            if (nums[i] + nums[mid] < lower) {  // If the sum is less than the lower bound
                left = mid + 1;  // Move the left pointer to the right
            } else {
                right = mid - 1;  // Otherwise, move the right pointer to the left
            }
        }
        
        const lowerBound = left;  // After the loop, `left` is the first valid index where `nums[i] + nums[left] >= lower`

        // Reset the `left` and `right` pointers for the upper bound binary search
        left = i + 1;
        right = n - 1;

        // Binary search for the upper bound:
        // Find the largest index `right` such that `nums[i] + nums[right] <= upper`
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);  // Find the middle index
            if (nums[i] + nums[mid] > upper) {  // If the sum is greater than the upper bound
                right = mid - 1;  // Move the right pointer to the left
            } else {
                left = mid + 1;  // Otherwise, move the left pointer to the right
            }
        }
        
        const upperBound = right;  // After the loop, `right` is the last valid index where `nums[i] + nums[right] <= upper`

        // Calculate the number of valid pairs for the current `i`:
        // The number of valid `j` values is the range between `lowerBound` and `upperBound`
        if (upperBound >= lowerBound) {
            count += upperBound - lowerBound + 1;  // Add the number of valid pairs to the count
        }
    }
    
    return count;  // Return the total count of valid pairs
}
