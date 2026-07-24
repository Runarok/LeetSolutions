function uniqueXorTriplets(nums: number[]): number {
    // ------------------------------------------------------------
    // nums is a permutation of [1 ... n]
    // Therefore only its length matters.
    // ------------------------------------------------------------
    const n = nums.length;

    // ------------------------------------------------------------
    // If there are fewer than 3 distinct numbers,
    // the only XOR values obtainable are the numbers themselves.
    //
    // Example:
    // n = 1 -> {1}
    // n = 2 -> {1,2}
    // ------------------------------------------------------------
    if (n < 3) {
        return n;
    }

    // ------------------------------------------------------------
    // Find how many bits are needed to represent n.
    //
    // Example:
    // n = 3  -> bits = 2
    // n = 5  -> bits = 3
    // n = 10 -> bits = 4
    // ------------------------------------------------------------
    let bits = 0;
    let x = n;

    while (x > 0) {
        bits++;
        x >>= 1;
    }

    // ------------------------------------------------------------
    // 2^bits
    //
    // This equals the smallest power of two strictly greater than n.
    //
    // Examples:
    // bits = 2 -> 4
    // bits = 3 -> 8
    // bits = 4 -> 16
    // ------------------------------------------------------------
    return 1 << bits;
}