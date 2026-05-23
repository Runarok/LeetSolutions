function check(nums: number[]): boolean {
    // This variable will count how many times
    // the order "breaks" in the array.
    //
    // In a sorted + rotated array,
    // there can be at most ONE drop.
    //
    // Example:
    // [3,4,5,1,2]
    //          ^
    // Only one drop: 5 -> 1
    let count = 0;

    // Loop through every element
    for (let i = 0; i < nums.length; i++) {

        // Current element
        let current = nums[i];

        // Next element
        // Using modulo (%) so the last element
        // compares with the first element.
        //
        // Example:
        // i = last index
        // (i + 1) % nums.length -> 0
        let next = nums[(i + 1) % nums.length];

        // If current number is greater than next,
        // that means the sorted order breaks.
        if (current > next) {
            count++;
        }

        // If more than one break exists,
        // it cannot be a sorted rotated array.
        if (count > 1) {
            return false;
        }
    }

    // If we reach here,
    // there was at most one break,
    // so the array is valid.
    return true;
}