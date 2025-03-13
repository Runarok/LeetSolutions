function minZeroArray(nums: number[], queries: number[][]): number {
    const n = nums.length;
    let left = 0, right = queries.length;

    // Zero array isn't formed after all queries are processed
    if (!canFormZeroArray(nums, queries, right)) {
        return -1;
    }

    // Binary Search
    while (left <= right) {
        const middle = left + Math.floor((right - left) / 2);
        if (canFormZeroArray(nums, queries, middle)) {
            right = middle - 1;
        } else {
            left = middle + 1;
        }
    }

    // Return earliest query that zero array can be formed
    return left;
}

function canFormZeroArray(nums: number[], queries: number[][], k: number): boolean {
    const n = nums.length;
    let totalSum = 0;
    const differenceArray: number[] = Array(n + 1).fill(0);

    // Process query
    for (let queryIndex = 0; queryIndex < k; queryIndex++) {
        const [start, end, val] = queries[queryIndex];

        // Process start and end of range
        differenceArray[start] += val;
        if (end + 1 < n) {
            differenceArray[end + 1] -= val;
        }
    }

    // Check if zero array can be formed
    for (let numIndex = 0; numIndex < n; numIndex++) {
        totalSum += differenceArray[numIndex];
        if (totalSum < nums[numIndex]) {
            return false;
        }
    }

    return true;
}
