func maxProfit(prices []int) int {
    // ------------------------------------------------------------
    // PROBLEM OVERVIEW (COMMENTS ONLY)
    // ------------------------------------------------------------
    //
    // We are given an array "prices" where:
    //   prices[i] = stock price on day i
    //
    // We are allowed to complete AT MOST TWO transactions.
    //
    // A transaction = BUY followed by SELL.
    //
    // IMPORTANT RULE:
    //   - You cannot hold more than one stock at a time.
    //   - You MUST sell before buying again.
    //
    // Goal:
    //   Return the MAXIMUM profit achievable.
    //
    // ------------------------------------------------------------
    // STRATEGY
    // ------------------------------------------------------------
    //
    // We use a dynamic programming / state-machine approach.
    //
    // We track FOUR states:
    //
    //   buy1  -> maximum profit after FIRST buy
    //   sell1 -> maximum profit after FIRST sell
    //   buy2  -> maximum profit after SECOND buy
    //   sell2 -> maximum profit after SECOND sell
    //
    // Each state represents the BEST profit achievable up to
    // the current day while being in that state.
    //
    // ------------------------------------------------------------
    // STATE MEANINGS
    // ------------------------------------------------------------
    //
    // buy1:
    //   - We have bought once
    //   - Profit is NEGATIVE because we spent money
    //
    // sell1:
    //   - We have completed one transaction
    //   - Profit is non-negative
    //
    // buy2:
    //   - We have bought again (second transaction)
    //   - Profit may go down again
    //
    // sell2:
    //   - We have completed two transactions
    //   - This is the FINAL ANSWER
    //
    // ------------------------------------------------------------
    // INITIALIZATION
    // ------------------------------------------------------------
    //
    // buy1  = -prices[0]
    // sell1 = 0
    // buy2  = -prices[0]
    // sell2 = 0
    //
    // Why?
    //   - Buying costs money (negative profit)
    //   - Selling before buying gives zero profit
    //
    // ------------------------------------------------------------
    // TRANSITIONS (FOR EACH PRICE)
    // ------------------------------------------------------------
    //
    // buy1  = max(buy1, -price)
    // sell1 = max(sell1, buy1 + price)
    // buy2  = max(buy2, sell1 - price)
    // sell2 = max(sell2, buy2 + price)
    //
    // Order MATTERS because each state depends on the previous ones.
    //
    // ------------------------------------------------------------
    // TIME & SPACE
    // ------------------------------------------------------------
    //
    // Time Complexity:  O(n)
    // Space Complexity: O(1)
    //
    // ------------------------------------------------------------

    // Edge case: if no prices, no profit
    if len(prices) == 0 {
        return 0
    }

    // Initialize states
    buy1 := -prices[0]  // cost of first buy
    sell1 := 0          // profit after first sell
    buy2 := -prices[0]  // cost of second buy
    sell2 := 0          // profit after second sell

    // Iterate through each day's price
    for i := 1; i < len(prices); i++ {
        price := prices[i]

        // Update first buy:
        // Either keep previous buy
        // Or buy today at a lower price
        if -price > buy1 {
            buy1 = -price
        }

        // Update first sell:
        // Either keep previous sell
        // Or sell today using best buy1
        if buy1+price > sell1 {
            sell1 = buy1 + price
        }

        // Update second buy:
        // Either keep previous second buy
        // Or buy today using profit from first sell
        if sell1-price > buy2 {
            buy2 = sell1 - price
        }

        // Update second sell:
        // Either keep previous second sell
        // Or sell today using best buy2
        if buy2+price > sell2 {
            sell2 = buy2 + price
        }
    }

    // sell2 holds the maximum profit after at most two transactions
    return sell2
}
