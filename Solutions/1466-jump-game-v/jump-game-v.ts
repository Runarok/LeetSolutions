function maxJumps(arr: number[], d: number): number {
    // Length of the array
    const n = arr.length;

    // Memoization array
    // dp[i] will store the maximum number of indices
    // we can visit starting from index i
    const dp: number[] = new Array(n).fill(-1);

    /**
     * DFS function
     * Returns the maximum jumps possible starting from index i
     */
    function dfs(i: number): number {

        // If already computed, return stored result
        if (dp[i] !== -1) {
            return dp[i];
        }

        // At minimum, we can always stay on current index
        let best = 1;

        // ---------------------------------------------------
        // Check LEFT side
        // ---------------------------------------------------

        // We can jump at most d steps left
        for (let j = i - 1; j >= Math.max(0, i - d); j--) {

            // Cannot jump if current value is NOT greater
            // Also blocks further searching in this direction
            if (arr[j] >= arr[i]) {
                break;
            }

            // Valid jump
            // Try jumping there and continue DFS
            best = Math.max(best, 1 + dfs(j));
        }

        // ---------------------------------------------------
        // Check RIGHT side
        // ---------------------------------------------------

        // We can jump at most d steps right
        for (let j = i + 1; j <= Math.min(n - 1, i + d); j++) {

            // Same blocking condition
            if (arr[j] >= arr[i]) {
                break;
            }

            // Valid jump
            best = Math.max(best, 1 + dfs(j));
        }

        // Store computed answer
        dp[i] = best;

        return best;
    }

    // Final answer
    // Try starting from every index
    let answer = 0;

    for (let i = 0; i < n; i++) {
        answer = Math.max(answer, dfs(i));
    }

    return answer;
}