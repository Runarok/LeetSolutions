function maximumLength(nums: number[]): number {
    const cnt = new Map<number, number>();

    // Count frequency
    for (const num of nums) {
        cnt.set(num, (cnt.get(num) || 0) + 1);
    }

    let ans = 1;

    // Handle value 1 separately
    if (cnt.has(1)) {
        const ones = cnt.get(1)!;
        ans = Math.max(ans, ones % 2 === 0 ? ones - 1 : ones);
    }

    // Try every value as the starting number
    for (const [start] of cnt) {
        if (start === 1) continue;

        let cur = start;
        let len = 0;

        while (true) {
            const f = cnt.get(cur);
            if (f === undefined) break;

            // Center of the sequence
            if (f === 1) {
                len++;
                break;
            }

            // Need next squared value to continue
            const next = cur * cur;
            if (!cnt.has(next)) {
                len++;
                break;
            }

            // Use two copies of current
            len += 2;
            cur = next;
        }

        ans = Math.max(ans, len);
    }

    return ans;
}