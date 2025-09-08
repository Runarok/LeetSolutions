// getNoZeroIntegers returns two no-zero integers whose sum is equal to n.
// A no-zero integer is a positive integer that does not contain any '0' digit.
func getNoZeroIntegers(n int) []int {
    // Helper function to check if a number is a "No-Zero" integer.
    hasZero := func(x int) bool {
        for x > 0 {
            if x%10 == 0 {
                return true // Found a zero digit
            }
            x /= 10 // Remove the last digit
        }
        return false // No zero digit found
    }

    // Try all possible splits of n into two integers a and b
    for a := 1; a < n; a++ {
        b := n - a // b is the remaining value to reach n

        // Check if both a and b are no-zero integers
        if !hasZero(a) && !hasZero(b) {
            return []int{a, b} // Found a valid pair
        }
    }

    // As per problem statement, there is always at least one valid answer
    // This line should never be reached
    return nil
}
