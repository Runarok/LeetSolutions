function findMissingAndRepeatedValues(grid: number[][]): number[] {
    const n = grid.length;
    const seen = new Set<number>();
    let repeated = -1;

    // Flatten the grid and find the repeated number
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            const num = grid[i][j];
            if (seen.has(num)) {
                repeated = num; // Number found twice
            } else {
                seen.add(num);
            }
        }
    }

    // Find the missing number (it should be the one missing from 1 to n^2)
    const totalNumbers = n * n;
    let missing = -1;
    for (let i = 1; i <= totalNumbers; i++) {
        if (!seen.has(i)) {
            missing = i;
            break;
        }
    }

    return [repeated, missing];
}
