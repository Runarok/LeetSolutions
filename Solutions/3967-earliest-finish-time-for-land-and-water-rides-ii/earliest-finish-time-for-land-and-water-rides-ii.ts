function earliestFinishTime(
    landStartTime: number[],
    landDuration: number[],
    waterStartTime: number[],
    waterDuration: number[]
): number {
    const INF = Number.POSITIVE_INFINITY;

    const build = (starts: number[], durations: number[]) => {
        const rides = starts
            .map((s, i) => [s, durations[i]] as const)
            .sort((a, b) => a[0] - b[0]);

        const sortedStarts = rides.map(r => r[0]);
        const sortedDurations = rides.map(r => r[1]);

        const n = rides.length;

        const prefixMinDuration = new Array<number>(n);
        prefixMinDuration[0] = sortedDurations[0];

        for (let i = 1; i < n; i++) {
            prefixMinDuration[i] = Math.min(
                prefixMinDuration[i - 1],
                sortedDurations[i]
            );
        }

        const suffixMinFinish = new Array<number>(n);
        suffixMinFinish[n - 1] =
            sortedStarts[n - 1] + sortedDurations[n - 1];

        for (let i = n - 2; i >= 0; i--) {
            suffixMinFinish[i] = Math.min(
                suffixMinFinish[i + 1],
                sortedStarts[i] + sortedDurations[i]
            );
        }

        return {
            sortedStarts,
            prefixMinDuration,
            suffixMinFinish,
        };
    };

    const upperBound = (arr: number[], target: number): number => {
        let left = 0;
        let right = arr.length;

        while (left < right) {
            const mid = (left + right) >> 1;
            if (arr[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    };

    const query = (
        endTime: number,
        starts: number[],
        prefixMinDuration: number[],
        suffixMinFinish: number[]
    ): number => {
        const n = starts.length;
        const idx = upperBound(starts, endTime);

        let best = INF;

        if (idx > 0) {
            best = Math.min(
                best,
                endTime + prefixMinDuration[idx - 1]
            );
        }

        if (idx < n) {
            best = Math.min(
                best,
                suffixMinFinish[idx]
            );
        }

        return best;
    };

    const water = build(waterStartTime, waterDuration);

    let answer = INF;

    for (let i = 0; i < landStartTime.length; i++) {
        const landEnd = landStartTime[i] + landDuration[i];

        answer = Math.min(
            answer,
            query(
                landEnd,
                water.sortedStarts,
                water.prefixMinDuration,
                water.suffixMinFinish
            )
        );
    }

    const land = build(landStartTime, landDuration);

    for (let i = 0; i < waterStartTime.length; i++) {
        const waterEnd = waterStartTime[i] + waterDuration[i];

        answer = Math.min(
            answer,
            query(
                waterEnd,
                land.sortedStarts,
                land.prefixMinDuration,
                land.suffixMinFinish
            )
        );
    }

    return answer;
}