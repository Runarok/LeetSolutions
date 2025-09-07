// sumZero returns an array of n unique integers that sum up to 0
func sumZero(n int) []int {
    // Create a slice with capacity n to hold the result
    res := make([]int, 0, n)

    // Add pairs of positive and negative integers
    // For example, if n = 4 → add (1, -1), (2, -2)
    for i := 1; i <= n/2; i++ {
        res = append(res, i, -i)
    }

    // If n is odd, add 0 to make the count n and keep the sum zero
    if n%2 != 0 {
        res = append(res, 0)
    }

    // Return the result slice
    return res
}
