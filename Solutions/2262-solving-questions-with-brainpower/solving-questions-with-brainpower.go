func mostPoints(questions [][]int) int64 {
    n := len(questions)
    // dp[i] stores the maximum points we can earn starting from question i
    dp := make([]int64, n+1) 

    // Iterate from the last question to the first
    for i := n - 1; i >= 0; i-- {
        // Option 1: Skip the current question, move to the next question
        skip := dp[i+1]

        // Option 2: Solve the current question
        // Earn points for the current question
        solve := int64(questions[i][0])

        // Determine the next question we can solve after skipping the blocked questions
        nextQuestion := i + questions[i][1] + 1

        // If there are still questions left after skipping, add their points
        if nextQuestion < n {
            solve += dp[nextQuestion]
        }

        // Choose the better option between solving or skipping the current question
        dp[i] = max(skip, solve)
    }

    // The maximum points we can earn starting from the first question
    return dp[0]
}

// Helper function to find the maximum of two int64 values
func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}
