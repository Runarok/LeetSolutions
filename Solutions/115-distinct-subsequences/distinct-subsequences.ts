function numDistinct(s: string, t: string): number {
    // ------------------------------------------------------------
    // PROBLEM SUMMARY (IN COMMENTS ONLY, AS REQUESTED)
    // ------------------------------------------------------------
    // We are given two strings:
    //   - s : the source string
    //   - t : the target string
    //
    // We must count how many DISTINCT subsequences of s equal t.
    //
    // A subsequence:
    //   - Keeps relative order of characters
    //   - Can delete characters but NOT reorder them
    //
    // Example:
    //   s = "rabbbit"
    //   t = "rabbit"
    //
    // There are 3 different ways to delete characters from s
    // such that the remaining characters form "rabbit".
    //
    // ------------------------------------------------------------
    // DYNAMIC PROGRAMMING APPROACH
    // ------------------------------------------------------------
    //
    // Let dp[i][j] = number of ways to form
    //                t[0..j-1] using s[0..i-1]
    //
    // Meaning:
    //   i -> length considered from s
    //   j -> length considered from t
    //
    // Final answer will be dp[s.length][t.length]
    //
    // ------------------------------------------------------------
    // BASE CASES
    // ------------------------------------------------------------
    //
    // 1) dp[i][0] = 1 for all i
    //    - There is exactly ONE way to form an empty string ""
    //      from any prefix of s: by deleting everything.
    //
    // 2) dp[0][j] = 0 for all j > 0
    //    - We cannot form a non-empty t from an empty s.
    //
    // ------------------------------------------------------------
    // TRANSITION
    // ------------------------------------------------------------
    //
    // If s[i-1] === t[j-1]:
    //   We have TWO choices:
    //     1) Use this character -> dp[i-1][j-1]
    //     2) Skip this character -> dp[i-1][j]
    //
    //   dp[i][j] = dp[i-1][j-1] + dp[i-1][j]
    //
    // If s[i-1] !== t[j-1]:
    //   We can ONLY skip the character from s
    //
    //   dp[i][j] = dp[i-1][j]
    //
    // ------------------------------------------------------------
    // SPACE OPTIMIZATION
    // ------------------------------------------------------------
    //
    // Since dp[i] only depends on dp[i-1],
    // we can optimize from 2D -> 1D.
    //
    // dp[j] will represent dp for the "current row".
    //
    // IMPORTANT:
    //   We must iterate j from RIGHT TO LEFT
    //   to avoid overwriting values needed for dp[j-1].
    //
    // ------------------------------------------------------------

    const m = s.length; // length of source string
    const n = t.length; // length of target string

    // dp[j] = number of ways to form t[0..j-1]
    // from processed prefix of s
    const dp: number[] = new Array(n + 1).fill(0);

    // Base case:
    // There is exactly 1 way to form empty t ("")
    dp[0] = 1;

    // Loop through characters of s (outer loop)
    for (let i = 1; i <= m; i++) {

        // Loop through characters of t (inner loop)
        // RIGHT TO LEFT is CRITICAL
        for (let j = n; j >= 1; j--) {

            // If characters match, we can either:
            //   - use this character
            //   - or skip it
            if (s[i - 1] === t[j - 1]) {
                dp[j] = dp[j] + dp[j - 1];
            }

            // If characters do NOT match:
            //   dp[j] stays the same
            //   (we can only skip s[i - 1])
        }
    }

    // dp[n] now holds the number of distinct subsequences
    // of s that equal t
    return dp[n];
}
