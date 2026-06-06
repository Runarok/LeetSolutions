function leftRightDifference(nums: number[]): number[] {
    // Length of the input array
    const n = nums.length;

    // Result array that will store the final answers
    const answer: number[] = new Array(n);

    // ---------------------------------------------------
    // Step 1: Calculate the total sum of all elements.
    // ---------------------------------------------------
    // This helps us efficiently compute right sums
    // without creating a separate rightSum array.
    let totalSum = 0;

    for (let i = 0; i < n; i++) {
        totalSum += nums[i];
    }

    // ---------------------------------------------------
    // Step 2: Traverse the array and calculate:
    // leftSum  = sum of elements before current index
    // rightSum = sum of elements after current index
    //
    // We maintain:
    // leftSum -> running sum of elements to the left
    // totalSum -> remaining sum including current element
    // ---------------------------------------------------
    let leftSum = 0;

    for (let i = 0; i < n; i++) {
        // Remove current element from totalSum.
        // After this, totalSum becomes the sum of
        // elements strictly to the right of index i.
        totalSum -= nums[i];

        // Now:
        // leftSum = sum of elements before i
        // totalSum = sum of elements after i
        const rightSum = totalSum;

        // Store absolute difference
        answer[i] = Math.abs(leftSum - rightSum);

        // Add current element to leftSum
        // so it becomes available for the next index.
        leftSum += nums[i];
    }

    // Return the final answer array
    return answer;
}