function predictTheWinner(nums: number[]): boolean {
    const n = nums.length;

    // Memoization table
    // memo[left][right] stores the maximum score difference
    // the current player can obtain from nums[left...right]
    const memo: (number | undefined)[][] = Array.from(
        { length: n },
        () => Array(n).fill(undefined)
    );

    // DFS + Memoization
    function dfs(left: number, right: number): number {

        // Base case:
        // Only one number left, current player takes it.
        if (left === right) {
            return nums[left];
        }

        // Return cached result if already computed.
        if (memo[left][right] !== undefined) {
            return memo[left][right]!;
        }

        // ----------------------------------------
        // Option 1:
        // Take the left number.
        //
        // We gain nums[left].
        // The opponent then plays optimally, so subtract
        // the score difference they can achieve.
        // ----------------------------------------
        const takeLeft = nums[left] - dfs(left + 1, right);

        // ----------------------------------------
        // Option 2:
        // Take the right number.
        // ----------------------------------------
        const takeRight = nums[right] - dfs(left, right - 1);

        // Choose the move that gives the larger advantage.
        memo[left][right] = Math.max(takeLeft, takeRight);

        return memo[left][right]!;
    }

    // If Player 1's best possible score difference
    // is non-negative, they can tie or win.
    return dfs(0, n - 1) >= 0;
}