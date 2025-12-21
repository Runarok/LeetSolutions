function minDeletionSize(strs: string[]): number {
    // Number of strings (rows)
    const n = strs.length;

    // Length of each string (columns)
    const m = strs[0].length;

    // sorted[i] means:
    // Have we ALREADY confirmed that strs[i] < strs[i + 1]
    // using the columns we decided to KEEP so far?
    //
    // If sorted[i] is true, we no longer need to worry
    // about comparing this pair in future columns.
    const sorted: boolean[] = new Array(n - 1).fill(false);

    // Count how many columns we delete
    let deletions = 0;

    // Iterate through each column from left to right
    // (important: lexicographic order depends on earlier columns first)
    for (let col = 0; col < m; col++) {

        // Flag to determine whether this column must be deleted
        let needDelete = false;

        // Check all adjacent row pairs
        for (let i = 0; i < n - 1; i++) {

            // If this pair is already sorted, we skip it
            // because earlier columns already guaranteed the order
            if (sorted[i]) continue;

            // If keeping this column causes a violation
            // (strs[i] > strs[i + 1]), lexicographic order breaks
            if (strs[i][col] > strs[i + 1][col]) {
                needDelete = true;
                break;
            }
        }

        // If the column causes any violation,
        // we must delete it and move to the next column
        if (needDelete) {
            deletions++;
            continue;
        }

        // Otherwise, the column is safe to keep.
        // Now we update which pairs become "sorted" thanks to this column.
        for (let i = 0; i < n - 1; i++) {

            // Only update pairs that are not already sorted
            if (!sorted[i] && strs[i][col] < strs[i + 1][col]) {
                // This column strictly orders the pair,
                // so future columns can ignore it
                sorted[i] = true;
            }
        }
    }

    // Return the minimum number of deleted columns
    return deletions;
}
