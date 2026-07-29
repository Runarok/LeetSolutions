function smallestPalindrome(s: string, k: number): string {
    // Frequency of each character
    const freq = new Array(26).fill(0);
    for (const ch of s) {
        freq[ch.charCodeAt(0) - 97]++;
    }

    // Half frequencies and middle character
    const half = new Array(26).fill(0);
    let middle = "";

    for (let i = 0; i < 26; i++) {
        half[i] = Math.floor(freq[i] / 2);
        if (freq[i] & 1) {
            middle = String.fromCharCode(97 + i);
        }
    }

    let total = 0;
    for (const x of half) total += x;

    const LIMIT = BigInt(k);

    // Compute C(n,r), capped at LIMIT.
    function comb(n: number, r: number): bigint {
        if (r < 0 || r > n) return 0n;
        r = Math.min(r, n - r);

        let res = 1n;

        for (let i = 1; i <= r; i++) {
            res = (res * BigInt(n - r + i)) / BigInt(i);
            if (res > LIMIT) return LIMIT;
        }

        return res;
    }

    // Count permutations of the multiset.
    function count(cnt: number[], len: number): bigint {
        let ans = 1n;
        let rem = len;

        for (let i = 0; i < 26; i++) {
            if (cnt[i] === 0) continue;

            ans *= comb(rem, cnt[i]);
            if (ans > LIMIT) ans = LIMIT;

            rem -= cnt[i];
        }

        return ans;
    }

    // Not enough palindromes.
    if (count(half, total) < BigInt(k)) return "";

    let left = "";

    while (total > 0) {
        for (let c = 0; c < 26; c++) {
            if (half[c] === 0) continue;

            half[c]--;
            total--;

            const ways = count(half, total);

            if (ways >= BigInt(k)) {
                left += String.fromCharCode(97 + c);
                break;
            }

            k -= Number(ways);

            half[c]++;
            total++;
        }
    }

    const right = left.split("").reverse().join("");

    return left + middle + right;
}