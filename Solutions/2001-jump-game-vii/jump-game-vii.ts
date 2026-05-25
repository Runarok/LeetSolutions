function canReach(s: string, minJump: number, maxJump: number): boolean {
    const n = s.length;

    // visited[i] = true means index i is reachable
    const visited: boolean[] = new Array(n).fill(false);
    visited[0] = true;

    // farthest index we have already processed
    let farthest = 0;

    for (let i = 0; i < n; i++) {
        // skip if current index is not reachable
        if (!visited[i]) continue;

        // calculate the jump range from current index
        const start = Math.max(i + minJump, farthest + 1);
        const end = Math.min(i + maxJump, n - 1);

        // try all new positions in range
        for (let j = start; j <= end; j++) {
            // only move to positions containing '0'
            if (s[j] === '0') {
                visited[j] = true;
            }
        }

        // update processed boundary
        farthest = end;

        // if last index becomes reachable
        if (visited[n - 1]) {
            return true;
        }
    }

    return visited[n - 1];
}