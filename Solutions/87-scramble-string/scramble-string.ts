function isScramble(s1: string, s2: string): boolean {
    // if lengths differ, s2 cannot be a scramble of s1
    if (s1.length !== s2.length) return false;

    // memoization map to store already computed results
    // key format: "s1|s2"
    const memo: Map<string, boolean> = new Map();

    // recursive helper function
    const dfs = (a: string, b: string): boolean => {
        // generate unique key for memoization
        const key = a + "|" + b;

        // if result already computed, return it
        if (memo.has(key)) return memo.get(key)!;

        // if strings are identical, they are trivially scrambled
        if (a === b) {
            memo.set(key, true);
            return true;
        }

        // if sorted characters do not match, pruning the recursion
        // scrambled strings must have the same character frequencies
        const arrA = a.split("").sort().join("");
        const arrB = b.split("").sort().join("");
        if (arrA !== arrB) {
            memo.set(key, false);
            return false;
        }

        // length of the current substring
        const n = a.length;

        // try all possible split positions
        for (let i = 1; i < n; i++) {
            // case 1: no swap
            // a = leftA + rightA
            // b = leftB + rightB
            if (
                dfs(a.substring(0, i), b.substring(0, i)) &&
                dfs(a.substring(i), b.substring(i))
            ) {
                memo.set(key, true);
                return true;
            }

            // case 2: swap
            // a = leftA + rightA
            // b = rightB + leftB
            if (
                dfs(a.substring(0, i), b.substring(n - i)) &&
                dfs(a.substring(i), b.substring(0, n - i))
            ) {
                memo.set(key, true);
                return true;
            }
        }

        // if no split leads to a valid scramble, return false
        memo.set(key, false);
        return false;
    };

    // start recursion from the full strings
    return dfs(s1, s2);
}
