function search(nums: number[], target: number): number {
    // We use binary search because:
    // - The array is sorted
    // - But it may be rotated
    // - We need O(log n) time complexity

    // Left pointer
    let left = 0;

    // Right pointer
    let right = nums.length - 1;

    // Continue searching while the window is valid
    while (left <= right) {

        // Find middle index
        // Math.floor prevents decimals
        const mid = Math.floor((left + right) / 2);

        // If we found the target, return its index
        if (nums[mid] === target) {
            return mid;
        }

        // IMPORTANT IDEA:
        // At least ONE HALF is always sorted

        // Check if LEFT HALF is sorted
        if (nums[left] <= nums[mid]) {

            // Now check if target lies inside the sorted left half
            if (target >= nums[left] && target < nums[mid]) {

                // Target is inside left half
                // Move right pointer inward
                right = mid - 1;

            } else {

                // Target is NOT in left half
                // Search the right half
                left = mid + 1;
            }

        } else {

            // Otherwise RIGHT HALF must be sorted

            // Check if target lies inside sorted right half
            if (target > nums[mid] && target <= nums[right]) {

                // Target is inside right half
                // Ignore left side
                left = mid + 1;

            } else {

                // Target is NOT in right half
                // Search left half
                right = mid - 1;
            }
        }
    }

    // If loop finishes, target does not exist
    return -1;
}