function lexicalOrder(n: number): number[] {
    // Result array to store numbers in lexicographical order
    const result: number[] = new Array(n);

    // Start from 1, which is the smallest lexicographical number in [1, n]
    let curr = 1;

    // Loop through all numbers from 1 to n
    for (let i = 0; i < n; i++) {
        // Place current number in the result array
        result[i] = curr;

        // Try to go to the next lexicographical number by multiplying by 10
        // This tries to go "deeper" in the lexicographical tree (e.g., from 1 to 10)
        if (curr * 10 <= n) {
            curr *= 10;
        } else {
            // If we can't go deeper, try to go to the next sibling (e.g., from 19 to 2)
            // We increment curr by 1
            if (curr >= n) curr = Math.floor(curr / 10);

            curr++;

            // If after incrementing, the last digit(s) become zero (i.e., we jumped out of the range)
            // we keep dividing by 10 to backtrack until we find a valid number in range and not ending with zero
            while (curr % 10 === 0) {
                curr = Math.floor(curr / 10);
            }
        }
    }

    return result;
}
