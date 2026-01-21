function minBitwiseArray(nums: number[]): number[] {
    const ans: number[] = [];

    for (const p of nums) {
        // If p is even, it's impossible
        if ((p & 1) === 0) {
            ans.push(-1);
            continue;
        }

        // Count trailing 1s
        let k = 0;
        let temp = p;
        while ((temp & 1) === 1) {
            k++;
            temp >>= 1;
        }

        // Minimum x
        const x = p - (1 << (k - 1));
        ans.push(x);
    }

    return ans;
}
