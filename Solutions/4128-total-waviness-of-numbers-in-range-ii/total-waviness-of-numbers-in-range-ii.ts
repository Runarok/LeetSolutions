function totalWaviness(num1: number, num2: number): number {

    function solve(limit: number): bigint {
        if (limit < 0) return 0n;

        const digits = String(limit).split("").map(Number);

        const memo = new Map<string, [bigint, bigint]>();
        // returns:
        // [countNumbers, totalWaviness]

        function dfs(
            pos: number,
            tight: boolean,
            started: boolean,
            prev2: number,
            prev1: number
        ): [bigint, bigint] {

            // Finished building a number.
            // No more digits to process.
            if (pos === digits.length) {
                return [1n, 0n];
            }

            const key =
                `${pos}|${started}|${prev2}|${prev1}`;

            // Only cache non-tight states.
            if (!tight && memo.has(key)) {
                return memo.get(key)!;
            }

            let ways = 0n;
            let wavinessSum = 0n;

            const upper = tight ? digits[pos] : 9;

            for (let d = 0; d <= upper; d++) {

                const nextTight =
                    tight && d === upper;

                // Still placing leading zeros.
                if (!started && d === 0) {
                    const [childWays, childSum] =
                        dfs(
                            pos + 1,
                            nextTight,
                            false,
                            -1,
                            -1
                        );

                    ways += childWays;
                    wavinessSum += childSum;
                    continue;
                }

                // First real digit of the number.
                if (!started) {
                    const [childWays, childSum] =
                        dfs(
                            pos + 1,
                            nextTight,
                            true,
                            -1,
                            d
                        );

                    ways += childWays;
                    wavinessSum += childSum;
                    continue;
                }

                let contribution = 0n;

                // Once we choose current digit d,
                // prev1 now has both neighbors:
                //
                // prev2  prev1  d
                //
                // So we can determine whether
                // prev1 is a peak or valley.
                if (prev2 !== -1) {

                    const peak =
                        prev1 > prev2 &&
                        prev1 > d;

                    const valley =
                        prev1 < prev2 &&
                        prev1 < d;

                    if (peak || valley) {
                        contribution = 1n;
                    }
                }

                const [childWays, childSum] =
                    dfs(
                        pos + 1,
                        nextTight,
                        true,
                        prev1,
                        d
                    );

                ways += childWays;

                // Every completion below inherits
                // the waviness contributed by prev1.
                wavinessSum +=
                    childSum +
                    contribution * childWays;
            }

            const result: [bigint, bigint] =
                [ways, wavinessSum];

            if (!tight) {
                memo.set(key, result);
            }

            return result;
        }

        return dfs(
            0,
            true,
            false,
            -1,
            -1
        )[1];
    }

    return Number(
        solve(num2) -
        solve(num1 - 1)
    );
}