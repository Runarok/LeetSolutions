func peopleAwareOfSecret(n int, delay int, forget int) int {
    mod := int(1e9 + 7)

    // dp[i] = number of people who learn the secret on day i
    dp := make([]int, n+1)
    dp[1] = 1

    // share[i] = number of people who can share the secret on day i
    share := make([]int, n+2) // n+2 to avoid index out of bounds

    share[1+delay] += 1       // person from day 1 starts sharing at day 1+delay
    share[1+forget] -= 1      // and forgets at day 1+forget

    for i := 2; i <= n; i++ {
        share[i] = (share[i] + share[i-1]) % mod
        dp[i] = share[i]
        if dp[i] < 0 {
            dp[i] += mod
        }

        // Person who learns today (dp[i]) will start sharing at day i+delay
        if i+delay <= n {
            share[i+delay] = (share[i+delay] + dp[i]) % mod
        }

        // Person will forget at day i+forget
        if i+forget <= n {
            share[i+forget] = (share[i+forget] - dp[i]) % mod
        }
    }

    // Total number of people who still remember the secret by day n
    total := 0
    for i := n - forget + 1; i <= n; i++ {
        total = (total + dp[i]) % mod
    }

    return total
}
