func maximumProfit(prices []int, k int) int64 {
    n := len(prices)

    dpPrev := make([]int64, n)
    dpCurr := make([]int64, n)

    for t := 1; t <= k; t++ {

        // Initialize using j = 0 (only valid start before i = 1)
        bestBuy  := dpPrev[0] - int64(prices[0])
        bestSell := dpPrev[0] + int64(prices[0])

        dpCurr[0] = 0 // cannot finish a transaction on day 0

        for i := 1; i < n; i++ {
            price := int64(prices[i])

            // Option 1: no transaction ends today
            dpCurr[i] = dpCurr[i-1]

            // Option 2: end a NORMAL transaction today
            dpCurr[i] = max64(dpCurr[i], price+bestBuy)

            // Option 3: end a SHORT transaction today
            dpCurr[i] = max64(dpCurr[i], bestSell-price)

            // IMPORTANT FIX:
            // Update bestBuy / bestSell using dpPrev[i-1]
            // This enforces j < i (no same-day overlap)
            bestBuy = max64(bestBuy, dpPrev[i-1]-price)
            bestSell = max64(bestSell, dpPrev[i-1]+price)
        }

        dpPrev, dpCurr = dpCurr, dpPrev
    }

    return dpPrev[n-1]
}

func max64(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}
