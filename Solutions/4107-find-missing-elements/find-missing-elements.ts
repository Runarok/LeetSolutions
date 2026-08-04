function findMissingElements(nums: number[]): number[] {
    // -------------------------------
    // Step 1: Find the smallest number
    // -------------------------------
    let min = Math.min(...nums);

    // -------------------------------
    // Step 2: Find the largest number
    // -------------------------------
    let max = Math.max(...nums);

    // -------------------------------------------------------
    // Step 3: Put every number from nums into a Set.
    // A Set allows O(1) lookup when checking if a number exists.
    // -------------------------------------------------------
    const seen = new Set(nums);

    // ------------------------------------
    // Step 4: Store missing numbers here.
    // ------------------------------------
    const missing: number[] = [];

    // ---------------------------------------------------
    // Step 5: Go through every number in the full range.
    // Example:
    // min = 1, max = 5
    // Loop checks: 1, 2, 3, 4, 5
    // ---------------------------------------------------
    for (let num = min; num <= max; num++) {

        // ------------------------------------------------
        // Step 6: If the current number is NOT in the Set,
        // it means it is missing from the original array.
        // ------------------------------------------------
        if (!seen.has(num)) {

            // -------------------------------
            // Add the missing number to answer.
            // -------------------------------
            missing.push(num);
        }
    }

    // ------------------------------------------------
    // Step 7: Return the sorted missing numbers.
    // They are already sorted because we checked
    // the range from smallest to largest.
    // ------------------------------------------------
    return missing;
}