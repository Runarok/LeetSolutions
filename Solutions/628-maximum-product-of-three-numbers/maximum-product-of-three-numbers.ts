function maximumProduct(nums: number[]): number {
    // ------------------------------------------------------------
    // Sort the array in ascending order.
    //
    // Example:
    // [3, -4, 5, -6, 2]
    // becomes
    // [-6, -4, 2, 3, 5]
    //
    // Sorting allows us to easily access:
    // - the three largest values
    // - the two smallest values
    // ------------------------------------------------------------
    nums.sort((a, b) => a - b);

    // Length of the array
    const n = nums.length;

    // ------------------------------------------------------------
    // Option 1:
    // Product of the three largest numbers.
    //
    // Example:
    // [1,2,3,4]
    // -> 2 * 3 * 4 = 24
    // ------------------------------------------------------------
    const largestThree =
        nums[n - 1] *
        nums[n - 2] *
        nums[n - 3];

    // ------------------------------------------------------------
    // Option 2:
    // Product of the two smallest numbers
    // (possibly large negative values)
    // and the largest number.
    //
    // Example:
    // [-10, -10, 5, 2]
    //
    // largestThree = -10
    // (-10 * -10 * 5) = 500  <-- actual maximum
    // ------------------------------------------------------------
    const smallestTwoLargest =
        nums[0] *
        nums[1] *
        nums[n - 1];

    // ------------------------------------------------------------
    // Return whichever product is larger.
    // ------------------------------------------------------------
    return Math.max(largestThree, smallestTwoLargest);
}