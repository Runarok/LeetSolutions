function maxTotalValue(nums: number[], k: number): number {
    const n = nums.length;

    // =====================================================
    // LOG TABLE
    // lg[i] = floor(log2(i))
    // Used by sparse table range queries.
    // =====================================================
    const lg = new Array(n + 1).fill(0);

    for (let i = 2; i <= n; i++) {
        lg[i] = lg[i >> 1] + 1;
    }

    // =====================================================
    // SPARSE TABLES
    //
    // mx[i][j] = maximum value in range:
    // [i, i + 2^j - 1]
    //
    // mn[i][j] = minimum value in range:
    // [i, i + 2^j - 1]
    //
    // Allows O(1) max/min queries.
    // =====================================================
    const LOG = lg[n] + 1;

    const mx: number[][] = Array.from(
        { length: n },
        () => new Array(LOG).fill(0)
    );

    const mn: number[][] = Array.from(
        { length: n },
        () => new Array(LOG).fill(0)
    );

    // Base level
    for (let i = 0; i < n; i++) {
        mx[i][0] = nums[i];
        mn[i][0] = nums[i];
    }

    // Build sparse tables
    for (let j = 1; j < LOG; j++) {
        const len = 1 << j;
        const half = len >> 1;

        for (let i = 0; i + len <= n; i++) {
            mx[i][j] = Math.max(
                mx[i][j - 1],
                mx[i + half][j - 1]
            );

            mn[i][j] = Math.min(
                mn[i][j - 1],
                mn[i + half][j - 1]
            );
        }
    }

    // =====================================================
    // Range value query:
    //
    // value(l,r)
    // = max(nums[l..r]) - min(nums[l..r])
    //
    // O(1)
    // =====================================================
    function getValue(l: number, r: number): number {
        const len = r - l + 1;
        const p = lg[len];

        const rangeMax = Math.max(
            mx[l][p],
            mx[r - (1 << p) + 1][p]
        );

        const rangeMin = Math.min(
            mn[l][p],
            mn[r - (1 << p) + 1][p]
        );

        return rangeMax - rangeMin;
    }

    // =====================================================
    // CUSTOM MAX HEAP
    //
    // Stores:
    // [value, leftIndex, rightIndex]
    // =====================================================
    class MaxHeap {
        heap: [number, number, number][] = [];

        size(): number {
            return this.heap.length;
        }

        push(node: [number, number, number]): void {
            this.heap.push(node);

            let i = this.heap.length - 1;

            while (i > 0) {
                const p = (i - 1) >> 1;

                if (this.heap[p][0] >= this.heap[i][0]) {
                    break;
                }

                [this.heap[p], this.heap[i]] =
                    [this.heap[i], this.heap[p]];

                i = p;
            }
        }

        pop(): [number, number, number] {
            const top = this.heap[0];

            const last = this.heap.pop()!;

            if (this.heap.length > 0) {
                this.heap[0] = last;

                let i = 0;

                while (true) {
                    let best = i;

                    const left = i * 2 + 1;
                    const right = i * 2 + 2;

                    if (
                        left < this.heap.length &&
                        this.heap[left][0] >
                            this.heap[best][0]
                    ) {
                        best = left;
                    }

                    if (
                        right < this.heap.length &&
                        this.heap[right][0] >
                            this.heap[best][0]
                    ) {
                        best = right;
                    }

                    if (best === i) break;

                    [this.heap[i], this.heap[best]] =
                        [this.heap[best], this.heap[i]];

                    i = best;
                }
            }

            return top;
        }
    }

    const heap = new MaxHeap();

    // =====================================================
    // Initial heap state
    //
    // For every starting position l,
    // push subarray [l ... n-1]
    // =====================================================
    for (let l = 0; l < n; l++) {
        heap.push([
            getValue(l, n - 1),
            l,
            n - 1
        ]);
    }

    // =====================================================
    // Repeatedly take the largest available value.
    //
    // After using (l,r),
    // push (l,r-1) if possible.
    // =====================================================
    let answer = 0;

    for (let take = 0; take < k; take++) {
        const [value, l, r] = heap.pop();

        answer += value;

        if (r > l) {
            heap.push([
                getValue(l, r - 1),
                l,
                r - 1
            ]);
        }
    }

    return answer;
}