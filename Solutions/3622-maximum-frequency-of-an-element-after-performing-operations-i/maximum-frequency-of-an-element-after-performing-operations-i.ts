function maxFrequency(nums: number[], k: number, numOperations: number): number {
    // Find the maximum number in the array
    const mx = Math.max(...nums);

    // Determine the size of the frequency and prefix arrays:
    // We extend beyond the max number by k + 2 to safely handle operations range
    const n = mx + k + 2;

    // Frequency array: f[x] will store how many times number x appears in nums
    const f = new Array(n).fill(0);
    for (const x of nums) f[x]++;  // Count frequency of each number in nums

    // Prefix sum array: pre[i] = total frequency count from f[0] to f[i]
    const pre = new Array(n).fill(0);
    pre[0] = f[0];
    for (let i = 1; i < n; i++) {
        pre[i] = pre[i - 1] + f[i];
    }

    let ans = 0;  // This will hold the maximum frequency achievable

    // Try making each value t the most frequent value
    for (let t = 0; t < n; t++) {
        // If t isn't in the original array and we have 0 operations, skip it
        if (f[t] == 0 && numOperations == 0) continue;

        // We consider values within range [t-k, t+k]
        // These are values we can convert to t using ≤ k cost per operation
        const l = Math.max(0, t - k);
        const r = Math.min(n - 1, t + k);

        // Total number of elements within range [l, r]
        const tot = pre[r] - (l > 0 ? pre[l - 1] : 0);

        // Exclude the current count of t itself — these don't need to be changed
        const adj = tot - f[t];

        // We can at most increase count of t by using numOperations
        // But we can't exceed the number of nearby elements we can change
        const val = f[t] + Math.min(numOperations, adj);

        // Update the answer with the maximum frequency found so far
        ans = Math.max(ans, val);
    }

    return ans;
}
