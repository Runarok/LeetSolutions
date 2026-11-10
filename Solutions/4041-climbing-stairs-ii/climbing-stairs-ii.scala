
object Solution {
    def climbStairs(n: Int, costs: Array[Int]): Int = {

        // dp(i) represents the minimum total cost required
        // to reach step i starting from step 0.
        //
        // We have n + 1 steps: 0, 1, 2, ..., n.
        val dp = new Array[Int](n + 1)

        // Base case:
        // We start at step 0 with a total cost of 0.
        dp(0) = 0

        // Iterate through every step from 1 to n.
        for (i <- 1 to n) {

            // Initially, set the minimum cost to a large value.
            // This will be updated by checking the previous steps.
            dp(i) = Int.MaxValue

            // We can reach step i from:
            // i - 1, i - 2, or i - 3.
            //
            // Check all three possible previous positions.
            for (jump <- 1 to 3) {

                // Calculate the previous step.
                val prev = i - jump

                // Make sure the previous step is not negative.
                if (prev >= 0) {

                    // Calculate the cost of jumping from prev to i.
                    //
                    // Formula:
                    // costs[i] + (i - prev)^2
                    //
                    // Since costs is 0-indexed in Scala:
                    // costs(i - 1) represents the cost of step i.
                    val jumpCost = costs(i - 1) + jump * jump

                    // Total cost =
                    // minimum cost to reach previous step
                    // + cost of the current jump.
                    val totalCost = dp(prev) + jumpCost

                    // Keep the minimum cost among all possibilities.
                    dp(i) = math.min(dp(i), totalCost)
                }
            }
        }

        // Return the minimum cost required to reach step n.
        dp(n)
    }
}
