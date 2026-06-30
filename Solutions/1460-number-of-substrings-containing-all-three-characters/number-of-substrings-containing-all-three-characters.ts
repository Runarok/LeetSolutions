function numberOfSubstrings(s: string): number {
    // Store how many times each character appears
    const count: Record<string, number> = {
        a: 0,
        b: 0,
        c: 0
    };

    // Left side of our sliding window
    let left = 0;

    // Final answer
    let ans = 0;

    // Length of the string
    const n = s.length;

    // Move the right pointer through the string
    for (let right = 0; right < n; right++) {

        // Include the current character into the window
        count[s[right]]++;

        // If the current window contains at least one
        // 'a', one 'b', and one 'c'
        while (
            count["a"] > 0 &&
            count["b"] > 0 &&
            count["c"] > 0
        ) {

            // Every substring starting at 'left'
            // and ending from 'right' to 'n-1'
            // will also contain all three characters.
            //
            // Example:
            // right = 4, n = 7
            // Valid endings:
            // 4, 5, 6
            // Count = 7 - 4 = 3
            ans += n - right;

            // We're about to move the left pointer,
            // so remove its character from the window.
            count[s[left]]--;

            // Shrink the window
            left++;
        }
    }

    return ans;
}