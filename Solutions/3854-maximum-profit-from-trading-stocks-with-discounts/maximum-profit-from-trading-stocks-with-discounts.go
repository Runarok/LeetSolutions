func maxProfit(
    n int,                     // number of employees (nodes)
    present []int,              // present[i] = cost to buy stock of employee i
    future []int,               // future[i] = selling price tomorrow
    hierarchy [][]int,          // boss → employee relationships
    budget int,                 // total money available
) int {

    // ----------------------------------------------------------
    // STEP 1: Build the company hierarchy as a tree
    // ----------------------------------------------------------
    // tree[u] will contain all direct subordinates of employee u
    tree := make([][]int, n)

    // Convert 1-based hierarchy to 0-based adjacency list
    for _, e := range hierarchy {
        boss := e[0] - 1
        emp  := e[1] - 1
        tree[boss] = append(tree[boss], emp)
    }

    // ----------------------------------------------------------
    // STEP 2: DP array definition
    // ----------------------------------------------------------
    // dp[u][pb][b] =
    //   maximum profit achievable in subtree rooted at u
    //   if parentBought = pb (0 = no, 1 = yes)
    //   using exactly b budget
    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, 2)
        for j := 0; j < 2; j++ {
            dp[i][j] = make([]int, budget+1)
        }
    }

    // ----------------------------------------------------------
    // STEP 3: Merge helper (knapsack convolution)
    // ----------------------------------------------------------
    // Combines two DP arrays A and B
    // C[x] = max(A[i] + B[j]) where i + j = x
    merge := func(A, B []int) []int {

        // Initialize merged DP with very small values
        C := make([]int, budget+1)
        for i := range C {
            C[i] = -1e9
        }

        // Try all valid budget splits
        for i := 0; i <= budget; i++ {

            // Skip invalid states
            if A[i] < 0 {
                continue
            }

            for j := 0; i+j <= budget; j++ {
                if C[i+j] < A[i]+B[j] {
                    C[i+j] = A[i] + B[j]
                }
            }
        }
        return C
    }

    // ----------------------------------------------------------
    // STEP 4: DFS with Tree DP
    // ----------------------------------------------------------
    var dfs func(int)

    dfs = func(u int) {

        // Process all children first (post-order traversal)
        for _, v := range tree[u] {
            dfs(v)
        }

        // Two cases:
        // pb = 0 → parent did NOT buy
        // pb = 1 → parent DID buy
        for pb := 0; pb <= 1; pb++ {

            // Determine buying price of u
            price := present[u]
            if pb == 1 {
                price /= 2   // discount applies
            }

            // Profit if u is bought
            profit := future[u] - price

            // --------------------------------------------------
            // OPTION 1: Skip buying u
            // --------------------------------------------------
            skip := make([]int, budget+1)

            // Children see parent as NOT bought
            for _, v := range tree[u] {
                skip = merge(skip, dp[v][0])
            }

            // --------------------------------------------------
            // OPTION 2: Buy u
            // --------------------------------------------------
            take := make([]int, budget+1)
            for i := range take {
                take[i] = -1e9
            }

            // Only possible if we can afford u
            if price <= budget {

                // Children see parent as BOUGHT
                base := make([]int, budget+1)
                for _, v := range tree[u] {
                    base = merge(base, dp[v][1])
                }

                // Add u's profit
                for b := price; b <= budget; b++ {
                    take[b] = base[b-price] + profit
                }
            }

            // --------------------------------------------------
            // Choose best of skip vs take
            // --------------------------------------------------
            for b := 0; b <= budget; b++ {
                dp[u][pb][b] = max(skip[b], take[b])
            }
        }
    }

    // Run DFS from the CEO (employee 0)
    dfs(0)

    // ----------------------------------------------------------
    // STEP 5: Final answer
    // ----------------------------------------------------------
    // CEO has no parent → parentBought = 0
    ans := 0
    for _, v := range dp[0][0] {
        if v > ans {
            ans = v
        }
    }
    return ans
}

// --------------------------------------------------------------
// Helper function for maximum of two integers
// --------------------------------------------------------------
func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
