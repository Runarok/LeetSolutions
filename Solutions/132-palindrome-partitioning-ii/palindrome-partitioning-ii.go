func minCut(s string) int {
    // ------------------------------------------------------------
    // MINIMUM CUTS FOR PALINDROME PARTITIONING
    // ------------------------------------------------------------
    //
    // Goal:
    //   - Partition the string s into substrings that are all palindromes
    //   - Return the minimum number of cuts needed
    //
    // Strategy:
    //   1) Precompute all palindromic substrings using DP (isPalindrome[i][j])
    //   2) Use DP to compute minCuts[i] = min cuts for substring s[0..i]
    //
    // ------------------------------------------------------------

    n := len(s) // length of the string

    // ------------------------------------------------------------
    // Step 1: Precompute palindromic substrings
    // ------------------------------------------------------------
    isPalindrome := make([][]bool, n) // isPalindrome[i][j] = true if s[i..j] is a palindrome
    for i := range isPalindrome {
        isPalindrome[i] = make([]bool, n)
    }

    // Fill DP table: substrings of length 1 and 2
    for i := 0; i < n; i++ {
        isPalindrome[i][i] = true // single letters are palindromes
    }

    for i := 0; i < n-1; i++ {
        if s[i] == s[i+1] {
            isPalindrome[i][i+1] = true // substrings of length 2
        }
    }

    // Expand for substrings of length >= 3
    for length := 3; length <= n; length++ { // length of substring
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] && isPalindrome[i+1][j-1] {
                isPalindrome[i][j] = true
            }
        }
    }

    // ------------------------------------------------------------
    // Step 2: Compute minimum cuts using DP
    // minCuts[i] = min cuts needed for s[0..i]
    // ------------------------------------------------------------
    minCuts := make([]int, n)
    for i := 0; i < n; i++ {
        if isPalindrome[0][i] {
            minCuts[i] = 0 // whole substring s[0..i] is palindrome => 0 cut
        } else {
            minCuts[i] = n // initialize with max possible cuts
            for j := 0; j < i; j++ {
                if isPalindrome[j+1][i] {
                    if minCuts[j]+1 < minCuts[i] {
                        minCuts[i] = minCuts[j] + 1
                    }
                }
            }
        }
    }

    return minCuts[n-1] // minimum cuts for the whole string
}
