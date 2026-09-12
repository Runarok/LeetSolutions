function maximumWeight(intervals: number[][]): number[] {
    const n = intervals.length;

    // Store each interval as:
    // [left, right, weight, originalIndex]
    //
    // Sorting by left endpoint lets us efficiently find the next
    // interval that starts strictly after the current interval ends.
    const arr = intervals.map((x, i) => [x[0], x[1], x[2], i]);

    arr.sort((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        return a[1] - b[1];
    });

    // Binary search:
    // Find the first interval whose left endpoint is > right.
    //
    // Notice the STRICT > here.
    // Intervals sharing a boundary are considered overlapping.
    function nextIndex(right: number): number {
        let lo = 0;
        let hi = n;

        while (lo < hi) {
            const mid = (lo + hi) >> 1;

            if (arr[mid][0] > right) {
                hi = mid;
            } else {
                lo = mid + 1;
            }
        }

        return lo;
    }

    // next[i] = first interval that can be selected after i.
    const next = new Int32Array(n);

    for (let i = 0; i < n; i++) {
        next[i] = nextIndex(arr[i][1]);
    }

    /*
     * We need at most 4 intervals, so we can use DP with only
     * 5 states.
     *
     * dp[k][i] represents the best result we can obtain using
     * intervals starting from position i, while still being allowed
     * to select at most k intervals.
     *
     * However, we also need lexicographically smallest indices when
     * scores are equal.
     *
     * Since we need to compare arrays of indices, storing actual
     * arrays in every DP state would be unnecessarily expensive.
     *
     * Instead, we use a persistent linked-list representation:
     *
     * Node:
     *   index -> selected original index
     *   next  -> next selected node
     *
     * All selected indices are kept in increasing original-index
     * order. This makes lexicographical comparison straightforward.
     */

    interface Node {
        index: number;
        next: number;
    }

    const nodes: Node[] = [];

    // Create a linked list from a state.
    //
    // Because we process intervals in increasing left endpoint,
    // simply prepending the current original index would NOT
    // necessarily give sorted original indices.
    //
    // Therefore, for the small maximum size (4), we use a compact
    // immutable representation below instead.
    interface State {
        score: number;
        indices: number[];
    }

    // A state with no selected intervals.
    const empty: State = {
        score: 0,
        indices: []
    };

    // Compare two states.
    //
    // First maximize total weight.
    // If weights are equal, choose the lexicographically smaller
    // array of original indices.
    function better(a: State, b: State): State {
        if (a.score !== b.score) {
            return a.score > b.score ? a : b;
        }

        const len = Math.min(a.indices.length, b.indices.length);

        for (let i = 0; i < len; i++) {
            if (a.indices[i] !== b.indices[i]) {
                return a.indices[i] < b.indices[i] ? a : b;
            }
        }

        // If one is a prefix of the other, the shorter array is
        // lexicographically smaller.
        return a.indices.length <= b.indices.length ? a : b;
    }

    /*
     * IMPORTANT:
     *
     * A straightforward DP that stores a JavaScript array in every
     * state can become expensive because there are 5 * 10^4
     * intervals. But k <= 4, so every state contains at most four
     * indices.
     *
     * We can therefore maintain only 5 DP arrays, each containing
     * the optimal state from every suffix.
     */

    // dp[k][i] = optimal state from interval i onward with at most
    // k intervals available.
    //
    // We only need the previous k layer while iterating k, but the
    // transition for taking an interval jumps to next[i].
    //
    // To avoid allocating huge numbers of nested arrays, use:
    // dp[k][i].
    const dp: State[][] = Array.from(
        { length: 5 },
        () => new Array<State>(n + 1)
    );

    // Base case:
    // With zero intervals allowed, the answer is always empty.
    for (let i = 0; i <= n; i++) {
        dp[0][i] = empty;
    }

    /*
     * Build the DP for k = 1..4.
     *
     * At each interval i we have two possibilities:
     *
     * 1. Skip interval i:
     *      dp[k][i + 1]
     *
     * 2. Take interval i:
     *      weight[i] + dp[k - 1][next[i]]
     *
     * The subtle part is lexicographical ordering.
     *
     * When we take an interval, we insert its ORIGINAL index into
     * the resulting list and keep the list sorted. Since k <= 4,
     * sorting a tiny array is effectively constant time.
     */

    for (let k = 1; k <= 4; k++) {
        dp[k][n] = empty;

        for (let i = n - 1; i >= 0; i--) {
            // Option 1: don't take this interval.
            const skip = dp[k][i + 1];

            // Option 2: take this interval.
            const tail = dp[k - 1][next[i]];

            // Copy at most 4 indices.
            const indices = tail.indices.slice();

            // Add the current interval's ORIGINAL index.
            indices.push(arr[i][3]);

            // The answer must be an array of indices in increasing
            // order, so sort the tiny array.
            indices.sort((a, b) => a - b);

            const take: State = {
                score: tail.score + arr[i][2],
                indices
            };

            // Keep whichever option has:
            //   1. larger score, or
            //   2. equal score but lexicographically smaller indices.
            dp[k][i] = better(skip, take);
        }
    }

    return dp[4][0].indices;
}
