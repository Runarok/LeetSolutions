impl Solution {
    pub fn find_min(nums: Vec<i32>) -> i32 {
        // ------------------------------------------------------------
        // We use a modified Binary Search.
        //
        // In a normal rotated sorted array WITHOUT duplicates:
        //   - We can always decide which side contains the minimum.
        //
        // But WITH duplicates:
        //   - nums[mid] == nums[right]
        //     becomes ambiguous.
        //
        // Example:
        //   [2,2,2,0,1]
        //
        // Binary search still works,
        // but in the worst case duplicates can force us
        // to shrink the search space one step at a time.
        //
        // Time Complexity:
        //   Average: O(log n)
        //   Worst Case: O(n)
        //
        // Space Complexity:
        //   O(1)
        // ------------------------------------------------------------

        // Left pointer
        let mut left = 0usize;

        // Right pointer
        let mut right = nums.len() - 1;

        // Continue until the search space becomes a single element
        while left < right {

            // Middle index
            // Avoids overflow compared to (left + right) / 2
            let mid = left + (right - left) / 2;

            // --------------------------------------------------------
            // CASE 1:
            // nums[mid] > nums[right]
            //
            // This means:
            //   Minimum MUST be on the RIGHT side.
            //
            // Example:
            //   [4,5,6,7,0,1,2]
            //          ^
            //        mid=7
            //
            // Since 7 > 2,
            // the rotation point is to the right.
            // --------------------------------------------------------
            if nums[mid] > nums[right] {
                left = mid + 1;
            }

            // --------------------------------------------------------
            // CASE 2:
            // nums[mid] < nums[right]
            //
            // This means:
            //   The RIGHT half is sorted properly,
            //   and the minimum could be at mid itself
            //   or somewhere to the LEFT.
            //
            // Example:
            //   [4,5,0,1,2]
            //        ^
            //      mid=0
            //
            // Since 0 < 2,
            // minimum is NOT to the right of mid.
            // --------------------------------------------------------
            else if nums[mid] < nums[right] {
                right = mid;
            }

            // --------------------------------------------------------
            // CASE 3:
            // nums[mid] == nums[right]
            //
            // We CANNOT determine which side has the minimum.
            //
            // Example:
            //   [2,2,2,0,2]
            //
            // mid and right are equal.
            //
            // Safest move:
            //   Shrink the search space by removing right.
            //
            // Why is this safe?
            //   Because nums[right] duplicates nums[mid],
            //   so removing it does not lose the minimum.
            //
            // This is the reason worst-case complexity
            // can degrade to O(n).
            // --------------------------------------------------------
            else {
                right -= 1;
            }
        }

        // At the end:
        // left == right
        //
        // That position contains the minimum value.
        nums[left]
    }
}