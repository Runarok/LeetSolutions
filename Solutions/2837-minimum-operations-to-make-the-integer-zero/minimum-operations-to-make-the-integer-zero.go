import "math/bits"

func makeTheIntegerZero(num1 int, num2 int) int {
    // Try all possible number of operations (k) from 1 to 60
    for k := 1; k <= 60; k++ {
        // Calculate totalPower needed: num1 - k * num2
        diff := num1 - k*num2

        // Skip if diff is negative or less than k (not enough to use k powers of two)
        if diff < k {
            continue
        }

        // Check if diff can be expressed as a sum of k powers of two
        // That means the number of set bits in diff (i.e., popcount) should be ≤ k
        if bits.OnesCount64(uint64(diff)) <= k {
            return k // Found the minimum number of operations
        }
    }

    // If no valid k found, return -1
    return -1
}
