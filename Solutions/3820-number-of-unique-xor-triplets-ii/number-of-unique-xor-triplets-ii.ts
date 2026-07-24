function uniqueXorTriplets(nums: number[]): number {
    // -------------------------------------------------------
    // Maximum possible value in nums is 1500.
    //
    // 1500 < 2048 = 2^11
    //
    // Therefore every XOR result also fits inside
    // the range [0, 2047].
    // -------------------------------------------------------
    const MAX_XOR = 2048;

    // -------------------------------------------------------
    // pairXor[x] = true
    // means there exists some pair (j, k) with j <= k
    // whose XOR equals x.
    // -------------------------------------------------------
    const pairXor = new Array<boolean>(MAX_XOR).fill(false);

    const n = nums.length;

    // -------------------------------------------------------
    // Compute every possible XOR of two elements.
    //
    // j <= k because repeated indices are allowed.
    //
    // Complexity: O(n²)
    // -------------------------------------------------------
    for (let j = 0; j < n; j++) {
        for (let k = j; k < n; k++) {
            pairXor[nums[j] ^ nums[k]] = true;
        }
    }

    // -------------------------------------------------------
    // answerXor[x] = true
    // means x can be formed as
    //
    // nums[i] ^ (nums[j] ^ nums[k])
    //
    // for some valid indices.
    // -------------------------------------------------------
    const answerXor = new Array<boolean>(MAX_XOR).fill(false);

    // -------------------------------------------------------
    // For every element,
    // combine it with every achievable pair XOR.
    //
    // There are only 2048 possible XOR values,
    // making this step O(n * 2048).
    // -------------------------------------------------------
    for (let i = 0; i < n; i++) {
        for (let x = 0; x < MAX_XOR; x++) {
            if (pairXor[x]) {
                answerXor[nums[i] ^ x] = true;
            }
        }
    }

    // -------------------------------------------------------
    // Count how many distinct XOR values were found.
    // -------------------------------------------------------
    let count = 0;

    for (let x = 0; x < MAX_XOR; x++) {
        if (answerXor[x]) {
            count++;
        }
    }

    return count;
}