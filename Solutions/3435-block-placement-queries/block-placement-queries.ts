function getResults(queries: number[][]): boolean[] {
    // Coordinate limit from the constraints.
    const MAX_X = 50000;

    // ---------------------------------------------------------
    // Collect every obstacle position that will ever exist.
    // We build the structure in the FINAL state (all obstacles
    // already inserted), then process queries backwards.
    // ---------------------------------------------------------
    const positions: number[] = [0, MAX_X];

    for (const q of queries) {
        if (q[0] === 1) {
            positions.push(q[1]);
        }
    }

    positions.sort((a, b) => a - b);

    const n = positions.length;

    // position -> index in sorted array
    const indexMap = new Map<number, number>();
    for (let i = 0; i < n; i++) {
        indexMap.set(positions[i], i);
    }

    // ---------------------------------------------------------
    // Fenwick Tree (BIT) for PREFIX MAXIMUM queries.
    //
    // At coordinate R we store the gap length of the segment
    // whose right endpoint is R.
    //
    // query(x) => maximum gap whose right endpoint <= x.
    // ---------------------------------------------------------
    class FenwickMax {
        tree: number[];

        constructor(size: number) {
            this.tree = new Array(size + 2).fill(0);
        }

        update(idx: number, value: number): void {
            idx++; // 1-based internally

            while (idx < this.tree.length) {
                this.tree[idx] = Math.max(this.tree[idx], value);
                idx += idx & -idx;
            }
        }

        query(idx: number): number {
            idx++;

            let res = 0;

            while (idx > 0) {
                res = Math.max(res, this.tree[idx]);
                idx -= idx & -idx;
            }

            return res;
        }
    }

    const bit = new FenwickMax(MAX_X + 2);

    // ---------------------------------------------------------
    // Initially we are in the FINAL state:
    // all obstacles from type-1 queries already exist.
    //
    // Adjacent positions define free gaps.
    // Store each gap at its right endpoint.
    // ---------------------------------------------------------
    for (let i = 1; i < n; i++) {
        const gap = positions[i] - positions[i - 1];
        bit.update(positions[i], gap);
    }

    // ---------------------------------------------------------
    // Doubly linked list of currently active obstacle positions.
    //
    // Used when removing an obstacle during reverse processing.
    // ---------------------------------------------------------
    const prev = new Array<number>(n);
    const next = new Array<number>(n);

    for (let i = 0; i < n; i++) {
        prev[i] = i - 1;
        next[i] = i + 1;
    }

    next[n - 1] = -1;

    // ---------------------------------------------------------
    // DSU for predecessor queries after deletions.
    //
    // find(i) = largest ACTIVE index <= i.
    //
    // When an obstacle is removed:
    // parent[idx] = find(idx - 1)
    // ---------------------------------------------------------
    const parent = new Array<number>(n);

    for (let i = 0; i < n; i++) {
        parent[i] = i;
    }

    const find = (x: number): number => {
        if (parent[x] === x) return x;
        return (parent[x] = find(parent[x]));
    };

    // Upper bound:
    // first index with positions[idx] > target
    const upperBound = (target: number): number => {
        let l = 0;
        let r = n;

        while (l < r) {
            const m = (l + r) >> 1;

            if (positions[m] <= target) {
                l = m + 1;
            } else {
                r = m;
            }
        }

        return l;
    };

    const answers: boolean[] = [];

    // ---------------------------------------------------------
    // Process queries backwards.
    // ---------------------------------------------------------
    for (let qi = queries.length - 1; qi >= 0; qi--) {
        const q = queries[qi];

        if (q[0] === 2) {
            const x = q[1];
            const sz = q[2];

            // Largest active obstacle <= x
            const idx = upperBound(x) - 1;
            const predIdx = find(idx);
            const predPos = positions[predIdx];

            // Best fully-contained gap ending at or before x
            const bestFinishedGap = bit.query(x);

            // Partial last segment from predecessor obstacle to x
            const tailGap = x - predPos;

            answers.push(Math.max(bestFinishedGap, tailGap) >= sz);
        } else {
            // Reverse of "add obstacle" = remove obstacle
            const pos = q[1];
            const idx = indexMap.get(pos)!;

            const left = prev[idx];
            const right = next[idx];

            // After removing this obstacle,
            // left and right become adjacent.
            const mergedGap = positions[right] - positions[left];

            // Gap ends at positions[right]
            bit.update(positions[right], mergedGap);

            // Remove from linked list
            next[left] = right;
            prev[right] = left;

            // Remove from DSU active set
            parent[idx] = find(idx - 1);
        }
    }

    answers.reverse();
    return answers;
}