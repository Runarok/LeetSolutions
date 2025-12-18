func maxProfit(prices []int, strategy []int, k int) int64 {
    n := len(prices)

    // Step 1: Compute original profit
    var baseProfit int64 = 0
    for i := 0; i < n; i++ {
        baseProfit += int64(strategy[i] * prices[i])
    }

    half := k / 2

    // Step 2: Precompute gain arrays
    // gainHold[i]: profit change if strategy[i] is forced to 0
    // gainSell[i]: profit change if strategy[i] is forced to 1
    gainHold := make([]int64, n)
    gainSell := make([]int64, n)

    for i := 0; i < n; i++ {
        gainHold[i] = int64(-strategy[i] * prices[i])
        gainSell[i] = int64((1 - strategy[i]) * prices[i])
    }

    // Step 3: Initialize sliding window sums
    var leftSum int64 = 0   // sum of gainHold for first half
    var rightSum int64 = 0  // sum of gainSell for second half

    // First window [0 ... k-1]
    for i := 0; i < half; i++ {
        leftSum += gainHold[i]
    }
    for i := half; i < k; i++ {
        rightSum += gainSell[i]
    }

    bestGain := leftSum + rightSum

    // Step 4: Slide the window
    for start := 1; start+k <= n; start++ {
        // Remove element leaving left half
        leftSum -= gainHold[start-1]

        // Add new element entering left half
        leftSum += gainHold[start+half-1]

        // Remove element leaving right half
        rightSum -= gainSell[start+half-1]

        // Add new element entering right half
        rightSum += gainSell[start+k-1]

        if leftSum+rightSum > bestGain {
            bestGain = leftSum + rightSum
        }
    }

    // Step 5: Return maximum possible profit
    // Modification is optional
    if baseProfit+bestGain > baseProfit {
        return baseProfit + bestGain
    }
    return baseProfit
}
