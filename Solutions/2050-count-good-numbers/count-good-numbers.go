const MOD = 1_000_000_007 // Modulo value to prevent integer overflow

// Fast modular exponentiation function
// Computes (x^n) % mod efficiently using exponentiation by squaring
func power(x, n, mod int64) int64 {
    result := int64(1) // Initialize result
    x = x % mod        // Reduce base if it's greater than mod

    for n > 0 {
        // If n is odd, multiply result by current x
        if n%2 == 1 {
            result = (result * x) % mod
        }
        // Square the base and reduce exponent by half
        x = (x * x) % mod
        n = n / 2
    }
    return result
}

// Main function to count the number of good digit strings of length n
func countGoodNumbers(n int64) int {
    // Count of even indices (0-based) → they must hold even digits
    evenCount := (n + 1) / 2 // If n is odd, we get one more even position

    // Count of odd indices → they must hold prime digits
    oddCount := n / 2

    // 5 choices for even positions: 0, 2, 4, 6, 8
    evenPow := power(5, evenCount, MOD)

    // 4 choices for odd positions: 2, 3, 5, 7
    oddPow := power(4, oddCount, MOD)

    // Total number of good strings = (5^evenCount * 4^oddCount) % MOD
    return int((evenPow * oddPow) % MOD)
}
