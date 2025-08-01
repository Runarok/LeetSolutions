function maxValue(events: number[][], k: number): number {
    events.sort((a, b) => a[0] - b[0]);  // Sort by start time
    const n = events.length;
    const starts = events.map(e => e[0]);
    const dp: number[][] = Array.from({ length: k + 1 }, () => Array(n).fill(-1));

    function dfs(curIndex: number, count: number): number {
        if (count === 0 || curIndex === n) return 0;
        if (dp[count][curIndex] !== -1) return dp[count][curIndex];

        const nextIndex = upperBound(starts, events[curIndex][1]);

        const skip = dfs(curIndex + 1, count);
        const take = events[curIndex][2] + dfs(nextIndex, count - 1);

        dp[count][curIndex] = Math.max(skip, take);
        return dp[count][curIndex];
    }

    // Custom binary search (upper_bound = first index with start > target)
    function upperBound(arr: number[], target: number): number {
        let left = 0, right = arr.length;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (arr[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }

    return dfs(0, k);
}
