function punishmentNumber(n: number): number {
    // Function to check if a square number can be partitioned into substrings
    // whose sum is equal to the original number
    function isValidPartition(s: string, target: number): boolean {
        const len = s.length;

        // Try all possible ways to partition the string into valid parts
        function dfs(index: number, sum: number): boolean {
            if (index === len) {
                return sum === target;
            }

            let part = 0;
            // Try every possible substring starting at index
            for (let i = index; i < len; i++) {
                part = part * 10 + Number(s[i]);  // Convert character to number
                if (sum + part > target) break;  // No need to continue if sum exceeds target
                if (dfs(i + 1, sum + part)) {
                    return true;
                }
            }
            return false;
        }

        return dfs(0, 0);
    }

    let totalPunishment = 0;

    // Iterate over all numbers from 1 to n
    for (let i = 1; i <= n; i++) {
        const square = i * i;
        const squareStr = square.toString();

        // Check if the number can be partitioned valid
        if (isValidPartition(squareStr, i)) {
            totalPunishment += square;
        }
    }

    return totalPunishment;
}
