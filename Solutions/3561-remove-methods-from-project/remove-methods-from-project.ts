function remainingMethods(n: number, k: number, invocations: number[][]): number[] {
    // ------------------------------------------------------------
    // Build the adjacency list.
    // graph[u] contains every method directly invoked by method u.
    // ------------------------------------------------------------
    const graph: number[][] = Array.from({ length: n }, () => []);

    for (const [from, to] of invocations) {
        graph[from].push(to);
    }

    // ------------------------------------------------------------
    // suspicious[i] = true if method i is suspicious.
    // A method is suspicious if:
    //   1. It is the buggy method k, or
    //   2. It can be reached from k through invocations.
    // ------------------------------------------------------------
    const suspicious: boolean[] = new Array(n).fill(false);

    // ------------------------------------------------------------
    // Perform DFS (using an explicit stack) starting from method k.
    // Every reachable method becomes suspicious.
    // ------------------------------------------------------------
    const stack: number[] = [k];
    suspicious[k] = true;

    while (stack.length > 0) {
        const current = stack.pop()!;

        // Visit every method invoked by the current method.
        for (const next of graph[current]) {
            // Skip already visited methods.
            if (suspicious[next]) continue;

            suspicious[next] = true;
            stack.push(next);
        }
    }

    // ------------------------------------------------------------
    // Check whether the suspicious group can actually be removed.
    //
    // It is impossible to remove the group if there exists an edge:
    //
    //      non-suspicious ----> suspicious
    //
    // because a remaining method would still invoke a removed method.
    // ------------------------------------------------------------
    for (const [from, to] of invocations) {
        if (!suspicious[from] && suspicious[to]) {
            // Removal is not allowed.
            // Return every method unchanged.
            const allMethods: number[] = [];
            for (let i = 0; i < n; i++) {
                allMethods.push(i);
            }
            return allMethods;
        }
    }

    // ------------------------------------------------------------
    // Removal is valid.
    // Collect every method that is NOT suspicious.
    // ------------------------------------------------------------
    const remaining: number[] = [];

    for (let i = 0; i < n; i++) {
        if (!suspicious[i]) {
            remaining.push(i);
        }
    }

    return remaining;
}