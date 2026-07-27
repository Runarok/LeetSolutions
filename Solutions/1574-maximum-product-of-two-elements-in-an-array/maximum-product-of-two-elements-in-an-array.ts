function maxProduct(nums: number[]): number {
    // Store the largest number found so far
    let first = 0;

    // Store the second largest number found so far
    let second = 0;

    // Traverse every element in the array
    for (const num of nums) {

        // If the current number is greater than or equal to
        // the current largest number, then:
        // 1. Move the old largest number to second largest.
        // 2. Update the largest number.
        if (num >= first) {
            second = first;
            first = num;
        }

        // Otherwise, if the current number is not the largest
        // but is larger than the current second largest,
        // update the second largest.
        else if (num > second) {
            second = num;
        }
    }

    // The maximum product is obtained by using
    // the two largest numbers in the array.
    // Subtract 1 from each number as required
    // by the problem statement.
    return (first - 1) * (second - 1);
}